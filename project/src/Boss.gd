class_name Boss
extends Area2D


export var boss_health := 1000

var boss_health_percent := 100
var boss_paused := true
var remaining_boss_health = boss_health
var rng := RandomNumberGenerator.new()


func _physics_process(_delta) -> void:
	boss_paused = get_parent().game_paused
	
	if boss_paused == false:
		_fire_bullet();


func _fire_bullet() -> void:
	var bullet = load("res://src/BossBullet.tscn").instance()
	rng.randomize()
	var random_num =  floor(rng.randf_range(0, 5))
	call_deferred("add_child", bullet)
	if random_num == 0:
		bullet.position = $Cannon1.position
	if random_num == 1:
		bullet.position = $Cannon2.position
	if random_num == 2:
		bullet.position = $Cannon3.position
	if random_num == 3:
		bullet.position = $Cannon4.position
	if random_num == 4:
		bullet.position = $Cannon5.position
		
	# Code below will randomly move around cannons
	#var randomX = rng.randf_range(-249, 269) # magic numbers representing current width of boss "sprite"
	#var cannonMovement := Vector2(randomX, 97) # magic number represetning current general y location of cannons
	#$Cannon1.set_position(cannonMovement)
	#$Cannon2.set_position(cannonMovement)
	#$Cannon3.set_position(cannonMovement)
	#$Cannon4.set_position(cannonMovement)
	#$Cannon5.set_position(cannonMovement)
