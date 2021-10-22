class_name MainMenu
extends Node2D


func _input(_event) -> void:
	if Input.is_action_just_pressed("play_game"):
		_on_PlayButton_pressed()
	if Input.is_action_just_pressed("instructions"):
		_on_InstructionsButton_pressed()
	if Input.is_action_just_pressed("quit_game"):
		_on_QuitButton_pressed()

func _on_PlayButton_pressed() -> void:
	var _ignored = get_tree().change_scene("res://src/Level.tscn")


func _on_InstructionsButton_pressed() -> void:
	var _ignored = get_tree().change_scene("res://src/Instructions.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
