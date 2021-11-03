class_name Boss
extends KinematicBody2D


export var boss_health := 1000

var boss_health_percent := 100
var boss_paused := true
var rng := RandomNumberGenerator.new()

var _remaining_boss_health = boss_health


func _physics_process(_delta) -> void:
	# Keeps the boss's health from going below 0, mostly for the counter
	_remaining_boss_health = clamp(_remaining_boss_health, 0, 1000)
	
	# Shows that the player has won the game
	boss_paused = get_parent().game_paused
	if boss_health == 0:
		get_parent().show_won_game()
	
	# Shoots the bullets if the game isn't paused
	if boss_paused == false:
		_fire_bullet();


# Creates instances of the bullets to fire at the player
func _fire_bullet() -> void:
	var bullet = load("res://src/BossBullet.tscn").instance()
	rng.randomize()
	var random_num =  floor(rng.randf_range(0, 5))
	get_node("/root/Level").call_deferred("add_child", bullet)
	if random_num == 0:
		bullet.global_position = $Cannon1.global_position
	if random_num == 1:
		bullet.global_position = $Cannon2.global_position
	if random_num == 2:
		bullet.global_position = $Cannon3.global_position
	if random_num == 3:
		bullet.global_position = $Cannon4.global_position
	if random_num == 4:
		bullet.global_position = $Cannon5.global_position
		
	# Code below will randomly move around cannons
	#var randomX = rng.randf_range(-249, 269) # magic numbers representing current width of boss "sprite"
	#var cannonMovement := Vector2(randomX, 97) # magic number represetning current general y location of cannons
	#$Cannon1.set_position(cannonMovement)
	#$Cannon2.set_position(cannonMovement)
	#$Cannon3.set_position(cannonMovement)
	#$Cannon4.set_position(cannonMovement)
	#$Cannon5.set_position(cannonMovement)


# Lowers the boss's health if they are hit
#  and removes the bullets that hit them
func _on_Area2D_area_entered(area):
		area.queue_free()
		boss_health -= 10
