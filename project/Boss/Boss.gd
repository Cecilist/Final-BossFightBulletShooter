class_name Boss
extends KinematicBody2D


export var boss_health: float = 100.0

var boss_health_percent: float = 100.0
var is_paused: bool = true
var spinners_count: int = 0

var _remaining_boss_health: float = boss_health
var _boss_can_shoot: bool = true
var _pattern_counter: int = 0



func _on_SpawnInTimer_timeout():
	$AnimatedSprite.show() 
	$CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D.disabled = false
	$PatternSwitcher.start()
	


func _physics_process(_delta):
	_remaining_boss_health = clamp(_remaining_boss_health, 0, 1000)

	is_paused = get_parent().is_paused
	
	if boss_health == 0:
		get_parent().show_won_game()
	
	boss_health_percent = _remaining_boss_health / boss_health
	boss_health_percent = clamp(boss_health_percent, 0, 100)
	
	# Needs to be implemented in a less overwhelming way
	#$BossShootingSound.play()
	
	if is_paused == false and _boss_can_shoot == true:
		_boss_can_shoot = false
		$BossShotTimer.start()
	
	if _boss_can_shoot == true:
		$PatternSwitcher.paused = true
	else:
		$PatternSwitcher.paused = false


func _on_BossShotTimer_timeout():
	_boss_can_shoot = true


func _on_PatternSwitcher_timeout():
	# Spawning in spinning squares of death is the only pattern for now,
	# Redundant code left in so devs don't forget how to make more patterns appear
	print("pattern Switch ", _pattern_counter % 2)
	if _pattern_counter % 2 == 0:
		if boss_health_percent >= .5:
			 _pattern_n_way_Straight()
		else:
			_pattern_3_spinner() 
	if _pattern_counter % 2 == 1:
		if boss_health_percent >= .5:
			 _pattern_1_spinner() 
		else:
			_pattern_3_spinner() 
	if _pattern_counter >= 2:
		_pattern_counter = 0
	_pattern_counter += 1
	
func _pattern_3_spinner():
	if spinners_count < 2:
		var spinner1: KinematicBody2D = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
		var spinner2: KinematicBody2D = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
		var spinner3: KinematicBody2D = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
		get_node("/root/Level/Boss").call_deferred("add_child", spinner1)
		spinner1.global_position = $SpinnerSpawn1.position
		get_node("/root/Level/Boss").call_deferred("add_child", spinner2)
		spinner2.global_position = $SpinnerSpawn2.position
		if spinners_count != 1:
			get_node("/root/Level/Boss").call_deferred("add_child", spinner3)
			spinner3.global_position = $SpinnerSpawn3.position
			spinners_count +=1
		spinners_count += 2
	
func _pattern_1_spinner(): 
	if spinners_count < 1:
		var spinner: KinematicBody2D = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
		get_node("/root/Level/Boss").call_deferred("add_child", spinner)
		spinner.global_position = $SpinnerSpawn3.position
		spinners_count += 1
			
func _pattern_n_way_Straight():
	var _pattern: Node2D = load("res://Boss/StaticPatterns/nWayStraight.tscn").instance()
	get_node("/root/Level/Boss").call_deferred("add_child", _pattern)
	_pattern.global_position = $AnimatedSprite.position
	
	

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		area.queue_free()
		_remaining_boss_health -= 5




