class_name Instructions
extends Node2D


func _input(_event) -> void:
	if Input.is_action_just_pressed("previous_menu"):
		_on_BackButton_pressed()


func _on_BackButton_pressed() -> void:
	var _ignored = get_tree().change_scene("res://src/MainMenu.tscn")
