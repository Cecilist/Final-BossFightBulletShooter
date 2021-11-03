class_name Instructions
extends Node2D


# Checks if the player pressed the key to return to the main menu
func _input(_event) -> void:
	if Input.is_action_just_pressed("previous_menu"):
		_on_BackButton_pressed()


# Returns to the menu
func _on_BackButton_pressed() -> void:
	var _ignored = get_tree().change_scene("res://src/Menu/MainMenu.tscn")
