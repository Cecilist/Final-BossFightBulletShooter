class_name nWayStraight
extends Node2D


export var _rotation_speed: int = 1
export var _shoot_time: float = 0.5
export var _cannons_count: float  = 16
export var _radius: int  = 100

var _bullet: PackedScene = preload("res://Boss/BossBullet.tscn")

onready var _shoot_timer = $Timer
onready var rotater = $Rotater

func _ready():
	var step = 2 * PI / _cannons_count
	
	for i in range(_cannons_count):
		var cannon = Node2D.new()
		var pos = Vector2(_radius, 0).rotated(step * i)
		cannon.position = pos
		cannon.rotation = pos.angle()
		rotater.add_child(cannon)
	
	_shoot_timer.wait_time = _shoot_time
	_shoot_timer.start()


func _process(delta: float) -> void:
	if get_parent().is_paused == false:
		var new_rotation = rotater.rotation_degrees + _rotation_speed * delta
		rotater.rotation_degrees = fmod(new_rotation, 360)


func _on_Timer_timeout() -> void:
	for i in rotater.get_children():
		if get_parent().is_paused == false:
			var bullet = _bullet.instance()
			bullet.add_to_group("Boss_Bullet")
			get_tree().root.add_child(bullet)
			bullet.position = i.global_position
			bullet.rotation = i.global_rotation


func _on_KillTimer_timeout():
	rotater.queue_free()
