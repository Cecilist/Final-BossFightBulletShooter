class_name Player
extends KinematicBody2D


export var player_health := 100
export var player_movement_speed := 250

var player_health_percent := 100.0

var _ship_velocity := Vector2(0,0)
var _remaining_player_health = player_health


func _physics_process(_delta) -> void:
	# Resets the player's velocity to stop them if no movement
	#  keys are pressed
	_ship_velocity = Vector2(0,0)
	
	# Moves the player based on which keys they press
	if Input.is_action_pressed("move_up"):
		_ship_velocity.y = player_movement_speed * -1
	if Input.is_action_pressed("move_down"):
		_ship_velocity.y = player_movement_speed
	if Input.is_action_pressed("move_left"):
		_ship_velocity.x = player_movement_speed * -1
	if Input.is_action_pressed("move_right"):
		_ship_velocity.x = player_movement_speed
	
	# Applies the velocity to the player
	_ship_velocity = move_and_slide(_ship_velocity, Vector2.UP)
	
	# Calculates how much health the player has as a percent
	#  to display it as part of the HUD
	player_health_percent = int(_remaining_player_health / player_health)


# Reduces the players health if they take damage
func _on_Hitbox_body_entered(_body) -> void:
	# If body == $Enemy || body == $EnemyProjectile:
	_remaining_player_health -= 10
