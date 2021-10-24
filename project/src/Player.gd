class_name Player
extends KinematicBody2D


export var player_health := 100
export var player_movement_speed := 250

var player_health_percent := 100
var ship_paused = false

var _ship_velocity := Vector2(0,0)
var _remaining_player_health = player_health





func _physics_process(_delta) -> void:
	# Checks if the game has been paused
	ship_paused = get_parent().game_paused
	
	# Resets the player's velocity to stop them if no movement
	#  keys are pressed
	_ship_velocity = Vector2(0,0)
	
	# If the game isn't paused, plays the animation and
	#  moves the player based on which keys they press
	if ship_paused == false:
		$ShipSprite.playing = true
		if Input.is_action_pressed("move_up"):
			_ship_velocity.y = player_movement_speed * -1
		if Input.is_action_pressed("move_down"):
			_ship_velocity.y = player_movement_speed
		if Input.is_action_pressed("move_left"):
			_ship_velocity.x = player_movement_speed * -1
		if Input.is_action_pressed("move_right"):
			_ship_velocity.x = player_movement_speed
		if Input.is_action_just_pressed("shoot"):
			shoot();

	# If the game is paused, stops playing the sprite's animation
	if ship_paused == true:
		$ShipSprite.playing = false
	
	# Applies the velocity to the player
	_ship_velocity = move_and_slide(_ship_velocity, Vector2.UP)
	
	# Calculates how much health the player has as a percent
	#  to display it as part of the HUD
	player_health_percent = int(_remaining_player_health / player_health)
	
func shoot():
	var bulletL = load("res://src/PlayerBullet.tscn").instance()
	var bulletR = load("res://src/PlayerBullet.tscn").instance()
	get_node("/root/Level").add_child(bulletL)
	bulletL.global_position = $LeftCannon.global_position
	get_node("/root/Level").add_child(bulletR)
	bulletR.global_position = $RightCannon.global_position
	
	
	


# Reduces the players health if they take damage
func _on_Hitbox_body_entered(_body) -> void:
	pass
	#if body == $Boss || body == $Boss_bullet:
		#_remaining_player_health -= 10

# using area, not body, for boss and bullets
# this works, but will break if we use areas for anything else
func _on_Hitbox_area_entered(_area) -> void:
		_remaining_player_health -= 10
		
