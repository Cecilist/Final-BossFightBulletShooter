class_name BossBullet
extends Area2D


var angle := 0


func _physics_process(_delta) -> void:
	position.y += 10
