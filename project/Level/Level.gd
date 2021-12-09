class_name Level
extends Node2D


var is_paused: bool = false
var is_game_over: bool = false
var is_won_game: bool = false
var is_unpaused: bool= true


var _unpause_time_remaining := "3"
var _previous_player_health: float = 100.0
var _button_pressed := ""


func _ready():
	$Overlay/Transition.fade_in()
	is_game_over = false
	is_won_game = false
	$AnimationPlayer.play("ShowKeybinds")


func _input(_event):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			_pause_game()
		elif get_tree().paused == true:
			_unpause_game()
	
	# Allows the player to use keybinds to interact with the pause menu
	if is_paused == true and $Overlay/Transition.input_locked == false:
		if Input.is_action_just_pressed("previous_menu"):
			_on_InGameToMenuButton_pressed()
		if Input.is_action_just_pressed("quit_game"):
			_on_InGameQuitButton_pressed()


func _process(_delta):
	if (is_paused == true and is_unpaused == true) and (is_won_game == false and is_game_over == false):
		_show_unpause_timer()
	
	if $Player.player_hit == true and (is_won_game == false and is_game_over == false):
		$AnimationPlayer.play("WhiteFlash")
	
	# Checks the player's health and displays it on the player's health bar
	$Overlay/HUD/PlayerHUD/PlayerHealth.scale.x = 2.25 * $Player.player_health_percent
	if $Player.player_health_percent == 0 and _button_pressed == "":
		$Player.player_death()
		show_game_over()
	
	# Checks the boss's health and displays it on the player's health bar
	$Overlay/HUD/BossHUD/BossHealth.scale.x = 2.25 * $Boss.boss_health_percent
	if $Boss.boss_health_percent == 0 and _button_pressed == "":
		show_won_game()
	
	$Overlay/HUD/PlayerHUD/FireRateStatusLabel.text = $Player.fire_rate_cooldown
	
	$Overlay/HUD/PlayerHUD/EvadeStatusLabel.text = $Player.evade_cooldown
	
	# Resets the player inside the level if their evade would take them
	#  out of the level
	if $Player.position.x < 0:
		$Player.position.x = 1
	if $Player.position.x > 719:
		$Player.position.x = 718
	
	if $Overlay/Transition.can_switch_scene == true:
		_new_scene()


func _pause_game():
	get_tree().paused = true
	is_paused = true
	if is_won_game == false and is_game_over == false:
		is_unpaused = false
		$Overlay/PauseMenu/InGameResumeButton.disabled = false
		$Overlay/PauseMenu/InGameToMenuButton.disabled = false
		$Overlay/PauseMenu/InGameQuitButton.disabled = false
		$Overlay/PauseMenu.visible = true


func _unpause_game():
	is_unpaused = true
	$Overlay/PauseMenu/InGameResumeButton.disabled = true
	$Overlay/PauseMenu/InGameToMenuButton.disabled = true
	$Overlay/PauseMenu/InGameQuitButton.disabled = true
	$Overlay/PauseMenu.visible = false
	$Timers/UnpauseTimer.start()


func show_game_over():
	is_game_over = true
	$Overlay/GameOver.visible = true
	$Overlay/EndButtons.visible = true
	$Overlay/EndButtons/ToMenuButton.disabled = false
	$Overlay/EndButtons/QuitButton.disabled = false


func show_won_game():
	is_won_game = true
	$Overlay/WonGame.visible = true
	$Overlay/EndButtons.visible = true
	$Overlay/EndButtons/ToMenuButton.disabled = false
	$Overlay/EndButtons/QuitButton.disabled = false


func _show_unpause_timer():
	_unpause_time_remaining = str(int(ceil($Timers/UnpauseTimer.get_time_left())))
	$Overlay/UnpauseLabel.visible = true
	$Overlay/UnpauseLabel.text = _unpause_time_remaining


func _new_scene():
	if _button_pressed == "menu":
		var _ignored := get_tree().change_scene("res:///Menu/MainMenu.tscn")
	elif _button_pressed == "quit":
		get_tree().quit()


func _on_InGameResumeButton_pressed():
	_unpause_game()


func _on_InGameToMenuButton_pressed():
	if is_paused == true:
		get_tree().paused = false
		$Overlay/PauseMenu.visible = false
		_button_pressed = "menu"
		$Overlay/Transition.show_rect()
		$Overlay/Transition.fade_out()


func _on_InGameQuitButton_pressed():
	if is_paused == true:
		get_tree().paused = false
		$Overlay/PauseMenu.visible = false
		_button_pressed = "quit"
		$Overlay/Transition.show_rect()
		$Overlay/Transition.fade_out()


func _on_UnpauseTimer_timeout():
	is_paused = false
	get_tree().paused = false
	$Overlay/UnpauseLabel.visible = false


func _on_ToMenuButton_pressed():
	if is_won_game == true || is_game_over == true:
		get_tree().paused = false
		$Overlay/PauseMenu.visible = false
		_button_pressed = "menu"
		is_paused = false
		is_won_game = false
		is_game_over = false
		$Overlay/Transition.show_rect()
		$Overlay/Transition.fade_out()


func _on_QuitButton_pressed():
	if is_won_game == true || is_game_over == true:
		get_tree().paused = false
		$Overlay/PauseMenu.visible = false
		_button_pressed = "quit"
		$Overlay/Transition.show_rect()
		$Overlay/Transition.fade_out()


func _on_BulletDespawnPoint_area_entered(area):
	area.queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "WhiteFlash":
		$Player.player_hit = false
