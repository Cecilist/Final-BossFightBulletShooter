class_name BossBullet
extends Area2D


var angle := 0


func _physics_process(_delta) -> void:
	if get_parent().boss_paused == false:
		position.y += 10
