extends Spatial

func _ready():
	$wind_turbine/AnimationPlayer.get_animation("Cylinder001Action").set_loop(true)
	$wind_turbine/AnimationPlayer.play("Cylinder001Action")
