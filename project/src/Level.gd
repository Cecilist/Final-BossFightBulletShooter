class_name Level
extends Node2D


func _process(_delta):
	if $Player.player_health_percent <= 100:
		$HUD/HealthBar.play("100")
	elif $Player.player_health_percent <= 90:
		$HUD/HealthBar.play("90")
	elif $Player.player_health_percent <= 80:
		$HUD/HealthBar.play("80")
	elif $Player.player_health_percent <= 70:
		$HUD/HealthBar.play("70")
	elif $Player.player_health_percent <= 60:
		$HUD/HealthBar.play("60")
	elif $Player.player_health_percent <= 50:
		$HUD/HealthBar.play("50")
	elif $Player.player_health_percent <= 40:
		$HUD/HealthBar.play("40")
	elif $Player.player_health_percent <= 30:
		$HUD/HealthBar.play("30")
	elif $Player.player_health_percent <= 20:
		$HUD/HealthBar.play("20")
	elif $Player.player_health_percent <= 10:
		$HUD/HealthBar.play("10")
	elif $Player.player_health_percent == 0:
		$HUD/HealthBar.play("0")
