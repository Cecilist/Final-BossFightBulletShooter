class_name Level
extends Node2D


var game_paused := false
var game_over := false
var won_game := false


# Pauses the game
func _input(_event) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			_pause_game()
		elif get_tree().paused == true:
			_unpause_game()
	if game_paused == true:
		if Input.is_action_just_pressed("previous_menu"):
			_on_InGameToMenuButton_pressed()
		if Input.is_action_just_pressed("to_next_screen"):
			_on_InGameRestartButton_pressed()
		if Input.is_action_just_pressed("quit_game"):
			_on_InGameQuitButton_pressed()


func _process(_delta) -> void:
	# Checks the player's health and displays it on the player's health bar
	if $Player.player_health_percent <= 100:
		$HUD/PlayerHealthBar.play("100")
	elif $Player.player_health_percent <= 90:
		$HUD/PlayerHealthBar.play("90")
	elif $Player.player_health_percent <= 80:
		$HUD/PlayerHealthBar.play("80")
	elif $Player.player_health_percent <= 70:
		$HUD/PlayerHealthBar.play("70")
	elif $Player.player_health_percent <= 60:
		$HUD/PlayerHealthBar.play("60")
	elif $Player.player_health_percent <= 50:
		$HUD/PlayerHealthBar.play("50")
	elif $Player.player_health_percent <= 40:
		$HUD/PlayerHealthBar.play("40")
	elif $Player.player_health_percent <= 30:
		$HUD/PlayerHealthBar.play("30")
	elif $Player.player_health_percent <= 20:
		$HUD/PlayerHealthBar.play("20")
	elif $Player.player_health_percent <= 10:
		$HUD/PlayerHealthBar.play("10")
	elif $Player.player_health_percent == 0:
		$HUD/PlayerHealthBar.play("0")
		_show_game_over()
	
	# Checks the boss's health and displays it on its health bar
#	if $Enemy.enemy_health_percent <= 100:
#		$HUD/EnemyHealthBar.play("100")
#	elif $Enemy.enemy_health_percent <= 90:
#		$HUD/EnemyHealthBar.play("90")
#	elif $Enemy.enemy_health_percent <= 80:
#		$HUD/EnemyHealthBar.play("80")
#	elif $Enemy.enemy_health_percent <= 70:
#		$HUD/EnemyHealthBar.play("70")
#	elif $Enemy.enemy_health_percent <= 60:
#		$HUD/EnemyHealthBar.play("60")
#	elif $Enemy.enemy_health_percent <= 50:
#		$HUD/EnemyHealthBar.play("50")
#	elif $Enemy.enemy_health_percent <= 40:
#		$HUD/EnemyHealthBar.play("40")
#	elif $Enemy.enemy_health_percent <= 30:
#		$HUD/EnemyHealthBar.play("30")
#	elif $Enemy.enemy_health_percent <= 20:
#		$HUD/EnemyHealthBar.play("20")
#	elif $Enemy.enemy_health_percent <= 10:
#		$HUD/EnemyHealthBar.play("10")
#	elif $Enemy.enemy_health_percent == 0:
#		$HUD/EnemyHealthBar.play("0")
#		_show_won_game()


func _pause_game() -> void:
	get_tree().paused = true
	$PauseMenu/InGameResumeButton.disabled = false
	$PauseMenu/InGameRestartButton.disabled = false
	$PauseMenu/InGameToMenuButton.disabled = false
	$PauseMenu/InGameQuitButton.disabled = false
	$PauseMenu.visible = true
	game_paused = true


func _unpause_game() -> void:
	get_tree().paused = false
	$PauseMenu/InGameResumeButton.disabled = true
	$PauseMenu/InGameRestartButton.disabled = true
	$PauseMenu/InGameToMenuButton.disabled = true
	$PauseMenu/InGameQuitButton.disabled = true
	$PauseMenu.visible = false
	game_paused = false


# Displays the game over message and allows the player to replay,
#  go the the main menu, or quit the game
func _show_game_over() -> void:
	$GameOver.visible = true
	$GameOver/ReplayButton.disabled = false
	$GameOver/ToMenuButton.disabled = false
	$GameOver/QuitButton.disabled = false


# Displays the won game message and allows the player to replay,
#  go the the main menu, or quit the game
func _show_won_game() -> void:
	$WonGame.visible = true
	$WonGame/ReplayButton.disabled = false
	$WonGame/ToMenuButton.disabled = false
	$WonGame/QuitButton.disabled = false


# Resumes the game
func _on_InGameResumeButton_pressed() -> void:
	game_paused = false


# Restarts the level
func _on_InGameRestartButton_pressed() -> void:
	if game_paused == true:
		var _ignored = get_tree().change_scene("res://src/Level.tscn")
		get_tree().paused = false
		game_paused = false


# Returns to the menu
func _on_InGameToMenuButton_pressed() -> void:
	if game_paused == true:
		var _ignored = get_tree().change_scene("res://src/MainMenu.tscn")
		get_tree().paused = false
		game_paused = false


# Quits the game
func _on_InGameQuitButton_pressed() -> void:
	if game_paused == true:
		get_tree().quit()
