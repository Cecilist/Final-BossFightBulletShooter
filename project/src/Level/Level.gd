class_name Level
extends Node2D


var game_paused := true
var game_over := false
var won_game := false
var bullet_velocity := 10

var _unpause_time_remaining : String = "3"
var _unpaused = true


func _ready():
	$Timers/UnpauseTimer.start()
	get_tree().paused = true
	game_over = false
	won_game = false


func _input(_event) -> void:
	# Pauses and unpauses the game
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			_pause_game()
		elif get_tree().paused == true:
			_unpause_game()
	
	# Allows the player to use keybinds to interact with the pause menu
	if game_paused == true:
		if Input.is_action_just_pressed("previous_menu"):
			_on_InGameToMenuButton_pressed()
		if Input.is_action_just_pressed("to_next_screen"):
			_on_InGameRestartButton_pressed()
		if Input.is_action_just_pressed("quit_game"):
			_on_InGameQuitButton_pressed()


func _process(_delta) -> void:
	# Checks the player's health and displays it on the player's health bar
	if won_game || game_over == true:
		_pause_game()
	
	# Displays the unpause timer
	if game_paused && _unpaused == true:
		_show_unpause_timer()
	
	# Displays the boss's remaining health
	$Overlay/BossHealth.text  = "Boss Health: %d" % $Boss.boss_health
	
	# Checks the boss's health and displays it on its health bar
#	if $Boss.boss_health_percent <= 100:
#		$Overlay/HUD/BossHealthBar.play("100")
#	elif $Boss.boss_health_percent <= 90:
#		$Overlay/HUD/BossHealthBar.play("90")
#	elif $Boss.boss_health_percent <= 80:
#		$Overlay/HUD/BossHealthBar.play("80")
#	elif $Boss.boss_health_percent <= 70:
#		$Overlay/HUD/BossHealthBar.play("70")
#	elif $Boss.boss_health_percent <= 60:
#		$Overlay/HUD/BossHealthBar.play("60")
#	elif $Boss.boss_health_percent <= 50:
#		$Overlay/HUD/BossHealthBar.play("50")
#	elif $Boss.boss_health_percent <= 40:
#		$Overlay/HUD/BossHealthBar.play("40")
#	elif $Boss.bossy_health_percent <= 30:
#		$Overlay/HUD/BossHealthBar.play("30")
#	elif $Boss.boss_health_percent <= 20:
#		$Overlay/HUD/BossHealthBar.play("20")
#	elif $Boss.boss_health_percent <= 10:
#		$Overlay/HUD/BossHealthBar.play("10")
#	elif $Boss.boss_health_percent == 0:
#		$Overlay/HUD/BossHealthBar.play("0")
#		_show_won_game()


# Pauses the game and brings up the pause menu
func _pause_game() -> void:
	get_tree().paused = true
	game_paused = true
	if won_game == false && game_over == false:
		_unpaused = false
		$Overlay/PauseMenu/InGameResumeButton.disabled = false
		$Overlay/PauseMenu/InGameRestartButton.disabled = false
		$Overlay/PauseMenu/InGameToMenuButton.disabled = false
		$Overlay/PauseMenu/InGameQuitButton.disabled = false
		$Overlay/PauseMenu.visible = true



# Unpauses the game and hides the pause menu
func _unpause_game() -> void:
	_unpaused = true
	$Overlay/PauseMenu/InGameResumeButton.disabled = true
	$Overlay/PauseMenu/InGameRestartButton.disabled = true
	$Overlay/PauseMenu/InGameToMenuButton.disabled = true
	$Overlay/PauseMenu/InGameQuitButton.disabled = true
	$Overlay/PauseMenu.visible = false
	$Timers/UnpauseTimer.start()


# Displays the game over message and allows the player to replay,
#  go the the main menu, or quit the game
func show_game_over() -> void:
	game_over = true
	$Overlay/GameOver.visible = true
	$Overlay/EndButtons.visible = true
	$Overlay/EndButtons/ReplayButton.disabled = false
	$Overlay/EndButtons/ToMenuButton.disabled = false
	$Overlay/EndButtons/QuitButton.disabled = false


# Displays the won game message and allows the player to replay,
#  go the the main menu, or quit the game
func show_won_game() -> void:
	won_game = true
	$Overlay/WonGame.visible = true
	$Overlay/EndButtons.visible = true
	$Overlay/EndButtons/ReplayButton.disabled = false
	$Overlay/EndButtons/ToMenuButton.disabled = false
	$Overlay/EndButtons/QuitButton.disabled = false


# Shows the time remaining until the game unpauses
func _show_unpause_timer() -> void:
	_unpause_time_remaining = str(int(ceil($Timers/UnpauseTimer.get_time_left())))
	$Overlay/UnpauseLabel.visible = true
	$Overlay/UnpauseLabel.text = _unpause_time_remaining


# Resumes the game
func _on_InGameResumeButton_pressed() -> void:
	game_paused = false
	_unpause_game()


# Restarts the level
func _on_InGameRestartButton_pressed() -> void:
	if game_paused == true:
		var _ignored = get_tree().change_scene("res://src/Level/Level.tscn")
		get_tree().paused = false
		game_paused = false


# Returns to the menu
func _on_InGameToMenuButton_pressed() -> void:
	if game_paused == true:
		var _ignored = get_tree().change_scene("res://src/Menu/MainMenu.tscn")
		get_tree().paused = false
		game_paused = false


# Quits the game
func _on_InGameQuitButton_pressed() -> void:
	if game_paused == true:
		get_tree().quit()


# Unpauses the game after the timer finishes
func _on_UnpauseTimer_timeout() -> void:
	game_paused = false
	get_tree().paused = false
	$Overlay/UnpauseLabel.visible = false


# Reloads the level
func _on_ReplayButton_pressed() -> void:
	if won_game == true || game_over == true:
		var _ignored = get_tree().change_scene("res://src/Level/Level.tscn")


# Returns to the menu
func _on_ToMenuButton_pressed() -> void:
	if won_game == true || game_over == true:
		var _ignored = get_tree().change_scene("res://src/Menu/MainMenu.tscn")


# Quits the game
func _on_QuitButton_pressed() -> void:
	if won_game == true || game_over == true:
		get_tree().quit()


# Once the bullets are offscreen, they are removed from the game
func _on_BulletDespawnPoint_area_entered(area) -> void:
	area.queue_free()