class_name BossBullet
extends Area2D


var _speed = 100
var _bullet_hit : bool = false

func _process(delta):
	#if get_parent().is_paused == false:
	position += transform.x * _speed * delta


func remove_bullet():
	_bullet_hit = true
	$boss_default.visible = false
	$Explosion.explode()
	$DespawnTimer.start()


func _on_DespawnTimer_timeout():
	self.queue_free()
