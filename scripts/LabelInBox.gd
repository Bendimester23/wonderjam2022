extends ColorRect

export var icon: Texture = null
export var text: String = ""

func _ready():
	$InnerBg/Label.text = text
	$InnerBg/Icon.texture = icon
