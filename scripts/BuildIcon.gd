extends Control

export(Resource) var product setget set_product
export(bool) var can_buy setget set_can_buy

signal bought(product)

func set_can_buy(new) -> void:
	$MarginContainer/HBoxContainer/BuyButton.disabled = !new

func set_product(new) -> void:
	product = new
	$MarginContainer/HBoxContainer/Name.text = new.label
	$MarginContainer/HBoxContainer/Icon.texture = new.icon
	$MarginContainer/HBoxContainer/BuyButton.text = new.buy_btn_text
	$MarginContainer/HBoxContainer/BuyButton.icon = new.buy_icon


func _on_BuyButton_pressed():
	emit_signal("bought", product)
