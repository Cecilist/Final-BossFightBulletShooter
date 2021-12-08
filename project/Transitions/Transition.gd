class_name Transition
extends Node2D


var can_switch_scene = false
var input_locked = false


func fade_in():
	$AnimationPlayer.play("FadeIn")
	input_locked = true


func fade_out():
	$ColorRect.set_position(Vector2(-725, -540))
	$AnimationPlayer.play("FadeOut")
	input_locked = true


func show_rect():
	$ColorRect.visible = true


func _on_AnimationPlayer_animation_finished(anim_name):
	input_locked = false
	if anim_name == "FadeIn":
		$ColorRect.visible = false
	elif anim_name == "FadeOut":
		can_switch_scene = true
