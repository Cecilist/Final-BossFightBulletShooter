class_name MainMenu
extends Node2D


var _button_pressed = " "

func _ready():
	get_tree().paused = false
	$AnimationPlayer.play("TitleFadeIn")


func _input(_event):
	if Input.is_action_just_pressed("play_game"):
		_on_PlayButton_pressed()
	if Input.is_action_just_pressed("to_next_screen"):
		_on_InstructionsButton_pressed()
	if Input.is_action_just_pressed("quit_game"):
		_on_QuitButton_pressed()


func _on_PlayButton_pressed():
	_button_pressed = "play"
	$ColorRect.visible = true
	$AnimationPlayer.play("TitleFadeOut")


func _on_InstructionsButton_pressed():
	_button_pressed = "instructions"
	$ColorRect.visible = true
	$AnimationPlayer.play("TitleFadeOut")


func _on_CreditsButton_pressed():
	_button_pressed = "credits"
	$ColorRect.visible = true
	$AnimationPlayer.play("TitleFadeOut")


func _on_QuitButton_pressed():
	_button_pressed = "quit"
	$ColorRect.visible = true
	$AnimationPlayer.play("TitleFadeOut")


func _on_DespawnArea_area_entered(area):
	area.queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "TitleFadeIn":
		$ColorRect.visible = false
	elif anim_name == "TitleFadeOut":
		if _button_pressed == "play":
			var _ignored := get_tree().change_scene("res:///Level/Level.tscn")
		elif _button_pressed == "instructions":
			var _ignored := get_tree().change_scene("res:///Menu/Instructions.tscn")
		elif _button_pressed == "credits":
			var _ignored := get_tree().change_scene("res:///Menu/Credits.tscn")
		elif _button_pressed == "quit":
			get_tree().quit()
