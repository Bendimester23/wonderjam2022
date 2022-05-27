extends Control

export(Texture) var icon
export(String) var item_name
export(String) var prop_name

func _ready():
	$MarginContainer/HBoxContainer/TextureRect.texture = icon
	$MarginContainer/HBoxContainer/NameAndVal.text = item_name + ": " + str(Inventory.get(prop_name))
	Inventory.connect("changed", self, "refresh_count")
	GlobalValues.connect("resource_rates_changed", self, "refresh_count")

func refresh_count():
	$MarginContainer/HBoxContainer/NameAndVal.text = item_name + ": " + str(round(Inventory.get(prop_name)))
	var rate = GlobalValues.get(prop_name + "_rate")
	var s = ""
	if rate > 0:
		s = "+"
		$MarginContainer/HBoxContainer/Rate.set("custom_colors/font_color", Color(0,1,0))
	elif rate < 0:
		s = "-"
		$MarginContainer/HBoxContainer/Rate.set("custom_colors/font_color", Color(1,0,0))
	else:
		$MarginContainer/HBoxContainer/Rate.set("custom_colors/font_color", Color(1,1,1))
	$MarginContainer/HBoxContainer/Rate.text = s + str(round(rate))
