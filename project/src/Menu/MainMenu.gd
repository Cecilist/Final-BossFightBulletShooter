class_name MainMenu
extends Node2D


# Fades in the title
func _ready():
	$AnimationPlayer.play("TitleFadeIn")


# Checks if the player pressed any of the buttons' corresponding keybinds
func _input(_event):
	if Input.is_action_just_pressed("play_game"):
		_on_PlayButton_pressed()
	if Input.is_action_just_pressed("to_next_screen"):
		_on_InstructionsButton_pressed()
	if Input.is_action_just_pressed("quit_game"):
		_on_QuitButton_pressed()


# Loads the level
func _on_PlayButton_pressed():
	var _ignored = get_tree().change_scene("res://src/Level/Level.tscn")


# Loads the instructions scene
func _on_InstructionsButton_pressed():
	var _ignored = get_tree().change_scene("res://src/Menu/Instructions.tscn")


# Quits the game
func _on_QuitButton_pressed():
	get_tree().quit()
