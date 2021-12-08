class_name Instructions
extends Node2D


func _ready():
	$Transition.fade_in()


# Checks if the player pressed the key to return to the main menu
func _input(_event):
	if Input.is_action_just_pressed("previous_menu"):
		_on_BackButton_pressed()


# Returns to the menu
func _process(_delta):
	if $Transition.can_switch_scene == true:
		var _ignored := get_tree().change_scene("res://Menu/MainMenu.tscn")


# Returns to the menu
func _on_BackButton_pressed():
	$Transition.show_rect()
	$Transition.fade_out()
