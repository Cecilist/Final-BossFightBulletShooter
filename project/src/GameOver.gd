class_name GameOver
extends Node2D


# Checks if the player pressed any of the buttons' corresponding keybinds
func _input(_event) -> void:
	if Input.is_action_just_pressed("play_game"):
		_on_ReplayButton_pressed()
	if Input.is_action_just_pressed("to_next_screen"):
		_on_ToMenuButton_pressed()
	if Input.is_action_just_pressed("quit_game"):
		_on_QuitButton_pressed()


# Reloads the level
func _on_ReplayButton_pressed() -> void:
	if get_parent().game_over == true:
		var _ignored = get_tree().change_scene("res://src/Level.tscn")


# Returns to the menu
func _on_ToMenuButton_pressed() -> void:
	if get_parent().game_over == true:
		var _ignored = get_tree().change_scene("res://src/MainMenu.tscn")


# Quits the game
func _on_QuitButton_pressed() -> void:
	if get_parent().game_over == true:
		get_tree().quit()
