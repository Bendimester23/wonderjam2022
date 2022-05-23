extends Control

export(float) var value = 0.0 setget set_value
export(String) var text = ""

func _ready():
	$Label.text = text

func set_value(new):
	$ProgressBar.value = new
	
