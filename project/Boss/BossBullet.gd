class_name BossBullet
extends Area2D


var _speed = 100

func _process(delta):
	#if get_parent().is_paused == false:
	position += transform.x * _speed * delta
	position += transform.y * _speed * delta
