extends Spatial

func _ready():
	$windmill/AnimationPlayer.get_animation("Cube001Action").set_loop(true)
	$windmill/AnimationPlayer.play("Cube001Action")
	pass
