class_name Player
extends KinematicBody2D


export var player_health := 100
export var player_movement_speed := 250

var player_health_percent := 100.0
var ship_paused := true

var _ship_velocity := Vector2(0,0)
var _remaining_player_health = player_health
var _player_invulnerable := false
var _can_shoot := true


func _physics_process(_delta) -> void:
	# Clamps the player's health
	_remaining_player_health = clamp(_remaining_player_health, 0, player_health)
	
	# Checks if the game has been paused
	ship_paused = get_parent().game_paused	
	
	# Resets the player's velocity to stop them if no movement
	#  keys are pressed
	_ship_velocity = Vector2(0,0)
	
	# If the game isn't paused, plays the animation and
	#  moves the player based on which keys they press
	if ship_paused == false:
		$ShipSprite.playing = true
		$ExhaustSprite.playing = true
		if Input.is_action_pressed("move_up"):
			_ship_velocity.y = player_movement_speed * -1
		if Input.is_action_pressed("move_down"):
			_ship_velocity.y = player_movement_speed
		if Input.is_action_pressed("move_left"):
			_ship_velocity.x = player_movement_speed * -1
		if Input.is_action_pressed("move_right"):
			_ship_velocity.x = player_movement_speed
		if Input.is_action_pressed("shoot"):
			if _can_shoot == true:
				shoot();

	# If the game is paused, stops playing the sprite's animation
	if ship_paused == true:
		$ShipSprite.playing = false
	
	# Applies the velocity to the player
	_ship_velocity = move_and_slide(_ship_velocity, Vector2.UP)
	
	# Calculates how much health the player has as a percent
	#  to display it as part of the HUD
	player_health_percent = 100 * _remaining_player_health / player_health
	player_health_percent = clamp(player_health_percent, 0, 100)
	
	# Checks the player's health and displays it on the player's health bar
	if player_health_percent <= 100:
		$Overlay/HUD/PlayerHealthBar.play("100")
	if player_health_percent <= 90:
		$Overlay/HUD/PlayerHealthBar.play("90")
	if player_health_percent <= 80:
		$Overlay/HUD/PlayerHealthBar.play("80")
	if player_health_percent <= 70:
		$Overlay/HUD/PlayerHealthBar.play("70")
	if player_health_percent <= 60:
		$Overlay/HUD/PlayerHealthBar.play("60")
	if player_health_percent <= 50:
		$Overlay/HUD/PlayerHealthBar.play("50")
	if player_health_percent <= 40:
		$Overlay/HUD/PlayerHealthBar.play("40")
	if player_health_percent <= 30:
		$Overlay/HUD/PlayerHealthBar.play("30")
	if player_health_percent <= 20:
		$Overlay/HUD/PlayerHealthBar.play("20")
	if player_health_percent <= 10:
		$Overlay/HUD/PlayerHealthBar.play("10")
	if player_health_percent == 0:
		$Overlay/HUD/PlayerHealthBar.play("0")
		get_parent().show_game_over()


# Shoots 2 bullets at the same time from the player
func shoot() -> void:
	var bulletL = load("res://src/Player/PlayerBullet.tscn").instance()
	var bulletR = load("res://src/Player/PlayerBullet.tscn").instance()
	get_node("/root/Level").add_child(bulletL)
	bulletL.global_position = $LeftCannon.global_position
	get_node("/root/Level").add_child(bulletR)
	bulletR.global_position = $RightCannon.global_position
	$PlayerShootingSound.play()
	_can_shoot = false
	$ShootTimer.start()


# Reduces the player's health if they are hit
#  and removes the bullets that hit them
func _on_Hitbox_area_entered(area) -> void:
	if _player_invulnerable == false:
		area.queue_free()
		_remaining_player_health -= 10
		_player_invulnerable = true
		$ShipSprite.play("damaged")
		$InvulnerabilityTimer.start()


# Removes the invulnerability on the player after they were hit
func _on_InvulnerabilityTimer_timeout() -> void:
	_player_invulnerable = false
	$ShipSprite.play("flying")


# Allows the cannons to shoot again, giving the shots a delay
#  when the player holds the shoot key
func _on_ShootTimer_timeout() -> void:
	_can_shoot = true
