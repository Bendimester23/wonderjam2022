extends ColorRect

export var icon: Texture = null
export var text: String = "" setget refresh_text

func refresh_text(new):
	text = new
	$InnerBg/Label.text = new

func _ready():
	$InnerBg/Label.text = text
	$InnerBg/Icon.texture = icon
