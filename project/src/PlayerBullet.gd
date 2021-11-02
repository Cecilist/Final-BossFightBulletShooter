class_name PlayerBullet
extends Area2D

func _physics_process(_delta):
	if get_parent().game_paused == false:
		position.y -= 10
	
