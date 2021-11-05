extends ParallaxBackground


# Starts scrolling the background
func _ready():
	$AnimationPlayer.play("Scroll")


# Checks if the animation has finished, then resets the position
#  of the second background layer
func _on_AnimationPlayer_animation_finished(_anim_name):
	$ParallaxLayer/SpaceBG2.position = Vector2(0, -2156.711)
	$AnimationPlayer.play("Scroll")
