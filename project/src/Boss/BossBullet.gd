class_name BossBullet
extends Area2D


var angle := 0


func _physics_process(_delta) -> void:
	# Moves the bullets if the game is not paused
	if get_parent().game_paused == false:
		position.y += 10
