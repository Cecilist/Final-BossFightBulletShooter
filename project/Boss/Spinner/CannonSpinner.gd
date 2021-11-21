extends KinematicBody2D

var _bullet = preload("res://Boss/Spinner/SpinnerBullets.tscn")

onready var _shoot_timer = $Timer
onready var rotater = $Rotater

export var _rotation_speed = 100
export var _shoot_time = 0.2
export var _cannons_count = 4
export var _radius = 100

var _health = 100


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
	if get_parent().boss_paused == false:
		var new_rotation = rotater.rotation_degrees + _rotation_speed * delta
		rotater.rotation_degrees = fmod(new_rotation, 360)
		if _health <= 0:
			get_parent().spinners_count -= 1
			print(get_parent().spinners_count)
			queue_free()

	
func _on_Timer_timeout() -> void:
	for i in rotater.get_children():
		if get_parent().boss_paused == false:
			var bullet = _bullet.instance()
			bullet.add_to_group("Boss_Bullet")
			get_tree().root.add_child(bullet)
			bullet.position = i.global_position
			bullet.rotation = i.global_rotation
			


func _on_DamageBox_area_entered(area):
	if area.is_in_group("Player"):
		area.queue_free()
		_health -= 10
		
