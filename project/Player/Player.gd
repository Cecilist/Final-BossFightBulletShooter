class_name Player
extends KinematicBody2D


signal health_changed

export var player_health: float = 100.0
export var player_movement_speed: int = 250
export var player_evade_distance: int = 200

var player_health_percent: float = 100.0
var is_paused: bool = true
var fire_rate_cooldown := "10"
var evade_cooldown := "5"
var can_player_shoot: bool = true

var _ship_velocity := Vector2(0,0)
var _remaining_player_health: float = player_health
var _is_player_invulnerable: bool = false
var _is_fire_rate_ability_ready: bool = true
var _is_fire_rate_ability_active:bool = false
var _is_evade_ability_ready:bool  = true
var _evade_direction := "left"


func _physics_process(_delta):
	_remaining_player_health = clamp(_remaining_player_health, 0, player_health)
	
	# Checks if the game has been paused
	is_paused = get_parent().is_paused
	
	# Resets the player's velocity to stop them if no movement
	#  keys are pressed
	_ship_velocity = Vector2(0,0)
	
	if is_paused == false:
		$ShipSprite.playing = true
		$ExhaustSprite.playing = true
		if Input.is_action_pressed("move_up"):
			_ship_velocity.y = player_movement_speed * -1
		if Input.is_action_pressed("move_down"):
			_ship_velocity.y = player_movement_speed
		if Input.is_action_pressed("move_left"):
			if Input.is_action_pressed("evade") and _is_evade_ability_ready == true:
				can_player_shoot = false
				_is_player_invulnerable = true
				_is_evade_ability_ready = false
				_evade_direction = "left"
				$AnimationPlayer.play("EvadeFadeOut")
				$EvadeCooldownTimer.start()
			else:
				_ship_velocity.x = player_movement_speed * -1
		if Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("evade") and _is_evade_ability_ready == true:
				can_player_shoot = false
				_is_player_invulnerable = true
				_is_evade_ability_ready = false
				_evade_direction = "right"
				$AnimationPlayer.play("EvadeFadeOut")
				$EvadeCooldownTimer.start()
			else:
				_ship_velocity.x = player_movement_speed
		if Input.is_action_pressed("shoot"):
			if can_player_shoot == true:
				shoot()
		if Input.is_action_pressed("fire_rate_ability"):
			if _is_fire_rate_ability_ready == true:
				_fire_rate_ability()

	if is_paused == true:
		$ShipSprite.playing = false
		$ExhaustSprite.playing = false
	
	_ship_velocity = move_and_slide(_ship_velocity, Vector2.UP)
	
	player_health_percent = _remaining_player_health / player_health
	player_health_percent = clamp(player_health_percent, 0, 100)
	
	if _is_fire_rate_ability_ready == false:
		fire_rate_cooldown = "ON COOLDOWN (" + str(int(ceil($FireRateCooldownTimer.time_left))) + ")"
	elif _is_fire_rate_ability_active == true:
		fire_rate_cooldown = "ACTIVE (" + str(int(ceil($FireRateTimer.time_left))) + ")"
	else:
		fire_rate_cooldown = "READY"

	if _is_evade_ability_ready == false:
		evade_cooldown = "ON COOLDOWN (" + str(int(ceil($EvadeCooldownTimer.time_left))) + ")"
	else:
		evade_cooldown = "READY"


func shoot():
	var bulletL = load("res://Player/PlayerBullet.tscn").instance()
	var bulletR = load("res://Player/PlayerBullet.tscn").instance()
	bulletL.add_to_group("Player")
	bulletR.add_to_group("Player")
	get_node("/root/Level").add_child(bulletL)
	bulletL.global_position = $LeftCannon.global_position
	get_node("/root/Level").add_child(bulletR)
	bulletR.global_position = $RightCannon.global_position
	$PlayerShootingSound.play()
	can_player_shoot = false
	$PlayerShotTimer.start()


# Doubles the player's fire rate for the duration of the FireRateTimer
func _fire_rate_ability():
	$PlayerShotTimer.wait_time = 0.2
	_is_fire_rate_ability_active = true
	$FireRateTimer.start()


func _on_Hitbox_area_entered(area):
	if _is_player_invulnerable == false:
		area.queue_free()
		_remaining_player_health -= 10
		_is_player_invulnerable = true
		$ShipSprite.play("damaged")
		$InvulnerabilityTimer.start()
		emit_signal("health_changed")


func _on_InvulnerabilityTimer_timeout():
	_is_player_invulnerable = false
	if $ShipSprite.animation == "damaged":
		$ShipSprite.play("flying")


# Allows the cannons to shoot again, giving the shots a delay
#  when the player holds the shoot key
func _on_PlayerShotTimer_timeout():
	can_player_shoot = true


func _on_FireRateTimer_timeout():
	$PlayerShotTimer.wait_time = 0.4
	_is_fire_rate_ability_ready = false
	_is_fire_rate_ability_active = false
	$FireRateCooldownTimer.start()


func _on_FireRateCooldownTimer_timeout():
	_is_fire_rate_ability_ready = true


func _on_EvadeCooldownTimer_timeout():
	_is_evade_ability_ready = true


# Makes the player evade, keeping them invulnerable until after
#  the animation is finished
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "EvadeFadeOut":
		if _evade_direction == "left":
			position.x -= player_evade_distance
		elif _evade_direction == "right":
			position.x += player_evade_distance
		$AnimationPlayer.play("EvadeFadeIn")
	elif anim_name == "EvadeFadeIn":
		_is_player_invulnerable = false
		can_player_shoot = true
