class_name Boss
extends KinematicBody2D


export var boss_health = 1000.0

var boss_health_percent = 100.0
var boss_paused = true

var _remaining_boss_health = boss_health
var _boss_can_shoot = true
var _pattern_counter = 0
var spinners_count = 0
var pattern : Node2D

func _ready():
	_pattern_n_way_Straight()
	$PatternSwitcher.start()


func _physics_process(_delta):
	# Keeps the boss's health from going below 0, mostly for the counter
	_remaining_boss_health = clamp(_remaining_boss_health, 0, 1000)
	
	# Shows that the player has won the game
	boss_paused = get_parent().game_paused
	if boss_health == 0:
		get_parent().show_won_game()
	
	# Calculates how much health the boss has as a percent
	#  to display it as part of the HUD
	boss_health_percent = _remaining_boss_health / boss_health
	boss_health_percent = clamp(boss_health_percent, 0, 100)
	print (boss_health_percent) 
	
	# Needs to be implemented in a less overwhelming way
	#$BossShootingSound.play()
	
	# Shoots the bullets if the game isn't paused
	if boss_paused == false and _boss_can_shoot == true:
		_boss_can_shoot = false
		$BossShotTimer.start()
	
	if _boss_can_shoot == true:
		$PatternSwitcher.paused = true
	else:
		$PatternSwitcher.paused = false
	
	


# Allows the boss to shoot again
func _on_BossShotTimer_timeout():
	_boss_can_shoot = true



func _on_PatternSwitcher_timeout():
	# Spawning in spinning squares of death is the only pattern for now,
	# Redundant code left in so devs don't forget how to make more patterns appear
	if _pattern_counter % 2 == 0:
		if boss_health_percent >= .5:
			 _pattern_1_spinner() 
		else:
			_pattern_3_spinner() 
		_pattern_counter += 1
	if _pattern_counter % 2 == 1:
		if boss_health_percent >= .5:
			 _pattern_1_spinner() 
		else:
			_pattern_3_spinner() 
		_pattern_counter += 1
	if _pattern_counter >= 2:
		_pattern_counter = 0
	
func _pattern_3_spinner():
	if spinners_count < 2:
		var spinner1 = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
		var spinner2 = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
		var spinner3 = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
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
		var spinner = load("res://Boss/Spinner/CannonSpinner.tscn").instance()
		get_node("/root/Level/Boss").call_deferred("add_child", spinner)
		spinner.global_position = $SpinnerSpawn3.position
		spinners_count += 1
			
func _pattern_n_way_Straight():
	var _pattern = load("res://Boss/StaticPatterns/nWayStraight.tscn").instance()
	get_node("/root/Level/Boss").call_deferred("add_child", _pattern)
	_pattern.global_position = $AnimatedSprite.position
	
	


# Lowers the boss's health if they are hit
#  and removes the bullets that hit them
func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		area.queue_free()
		_remaining_boss_health -= 5
