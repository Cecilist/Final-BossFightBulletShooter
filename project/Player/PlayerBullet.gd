class_name PlayerBullet
extends Area2D


var _bullet_hit : bool = false


func _physics_process(_delta):
	if get_parent().is_paused == false and _bullet_hit == false:
		position.y -= 10


func remove_bullet():
	_bullet_hit = true
	$Sprite.visible = false
	$Explosion.explode()
	$DespawnTimer.start()


func _on_DespawnTimer_timeout():
	self.queue_free()
