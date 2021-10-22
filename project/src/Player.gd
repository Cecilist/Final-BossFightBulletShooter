class_name Player
extends KinematicBody2D


export var player_health := 100
export var player_movement_speed := 250

var _ship_velocity := Vector2(0,0)


func _physics_process(_delta):
	_ship_velocity = Vector2(0,0)
	if Input.is_action_pressed("move_up"):
		_ship_velocity.y = player_movement_speed * -1
	if Input.is_action_pressed("move_down"):
		_ship_velocity.y = player_movement_speed
	if Input.is_action_pressed("move_left"):
		_ship_velocity.x = player_movement_speed * -1
	if Input.is_action_pressed("move_right"):
		_ship_velocity.x = player_movement_speed
	
	_ship_velocity = move_and_slide(_ship_velocity, Vector2.UP)
