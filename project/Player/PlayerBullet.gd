class_name PlayerBullet
extends Area2D


func _physics_process(_delta):
	# Moves the player's bullets if the game is not paused
	if get_parent().game_paused == false:
		position.y -= 10
	
