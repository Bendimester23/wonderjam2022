extends Control

export(Resource) var product setget set_product
export(bool) var can_buy setget set_can_buy

func set_can_buy(new) -> void:
	$MarginContainer/HBoxContainer/Button.disabled = !new

func set_product(new) -> void:
	$MarginContainer/HBoxContainer/Name.text = new.label
	$MarginContainer/HBoxContainer/Icon.texture = new.icon
	$MarginContainer/HBoxContainer/Button.text = new.buy_btn_text
	$MarginContainer/HBoxContainer/Button.icon = new.buy_icon
