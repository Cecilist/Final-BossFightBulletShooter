extends Area2D

export var boss_health := 1000

var boss_health_percent := 100
var boss_paused = false

var remaining_boss_health = boss_health

func _physics_process(_delta) -> void:
	boss_paused = get_parent().game_paused
	
	if boss_paused == false:
		_fire_bullet();
		
	
func _fire_bullet():
	var bullet = load("res://src/Boss_bullet.tscn").instance()
	get_node("/root/Level").add_child(bullet)
	bullet.global_position = $Cannon3.global_position
	
	
	
	
