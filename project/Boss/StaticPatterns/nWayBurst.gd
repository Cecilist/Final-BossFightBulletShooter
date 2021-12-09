class_name nWayBurst
extends Node2D


export var _rotation_speed: int = 0
export var _shoot_time: float = 0.3
export var _cannons_count: float  = 5
export var _radius: int  = 1

var _bullet: PackedScene = preload("res://Boss/BossBullet.tscn")

onready var _shoot_timer = $Timer
onready var rotater = $Rotater

func _ready():
	$KillTimer.start()
	$KillTimer.one_shot = true
	var step = (PI) / _cannons_count
	
	for i in range(_cannons_count):
		var cannon = Node2D.new()
		var pos = Vector2(_radius, 0).rotated(step * i)
		cannon.position = pos
		cannon.rotation = pos.angle()
		rotater.add_child(cannon)
	
	_shoot_timer.wait_time = _shoot_time
	_shoot_timer.start()





func _on_Timer_timeout() -> void:
	for i in rotater.get_children():
		if get_parent().is_paused == false:
			var bullet = _bullet.instance()
			bullet.add_to_group("Boss_Bullet")
			get_tree().root.add_child(bullet)
			bullet.position = i.global_position
			bullet.rotation = i.global_rotation


func _on_KillTimer_timeout():
	queue_free()
	
