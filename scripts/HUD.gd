extends Control

onready var level_label = $Level/Label
onready var stats_window = $StatsWindow
onready var build_menu = $BuildMenu
onready var inventory_menu = $InventoryWindow

var stats_window_shown = false
var build_menu_shown = false
var inventory_menu_shown = false

export var sell_prices = {
	"coal": 0.0,
	"iron": 0.0,
	"gems": 0.0,
	
	"water": 0.0,
	"oil": 0.0
}

func _process(_delta):
	if is_something_open() and Input.is_action_just_pressed("ui_cancel"):
		stats_window.hide()
		build_menu.hide()
		inventory_menu.hide()
		stats_window_shown = false
		build_menu_shown = false
		inventory_menu_shown = false
		GlobalValues.allow_movement = true

func is_something_open() -> bool:
	return stats_window_shown or build_menu_shown or inventory_menu_shown

func set_current_level(num: int) -> void:
	GlobalValues.current_floor_type = GlobalRoomManager.get_room_info().type
	if GlobalRoomManager.get_room_info().locked:
		$BuildButton/Button.disabled = true
		$BuildButton/Buy.disabled = false
	else:
		$BuildButton/Button.disabled = false
		$BuildButton/Buy.disabled = true
	level_label.text = str(num)

func _on_StatsButton_pressed():
	if stats_window_shown:
		stats_window.hide()
		stats_window_shown = false
		GlobalValues.allow_movement = true
		return
	elif !is_something_open():
		stats_window.show()
		stats_window_shown = true
		GlobalValues.allow_movement = false
		stats_window.refresh()

func _ready():
	GlobalValues.connect("money_changed", self, "_on_money_changed")
	GlobalValues.connect("power_usage_changed", self, "_on_power_usage_changed")
	_on_money_changed()

func _on_money_changed():
	$BottomBar/Money.text = str(round(GlobalValues.money)) + "$"

func _on_power_usage_changed():
	$BottomBar/PowerUsage.text = str(GlobalValues.power_usage) + "kW/h"

func _on_Build_pressed():
	if !is_something_open():
		build_menu.show()
		build_menu_shown = true
		GlobalValues.allow_movement = false
	else:
		build_menu.hide()
		build_menu_shown = false
		GlobalValues.allow_movement = true


func _on_Sell_pressed(type):
	GlobalValues.money += sell_prices[type] * Inventory.get(type)
	Inventory.set(type, 0)
	Inventory.emit_signal("changed")


func _on_InventoryButton_pressed():
	if !is_something_open():
		inventory_menu.show()
		inventory_menu_shown = true
		GlobalValues.allow_movement = false
	else:
		inventory_menu.hide()
		inventory_menu_shown = false
		GlobalValues.allow_movement = true

func _on_Buy_pressed():
	if GlobalValues.money >= GlobalRoomManager.get_current_room_price():
		$BuyConfirm.dialog_text = "Are you sure you want to buy this floor for " + str(round(GlobalRoomManager.get_current_room_price())) + "$?"
		$BuyConfirm.popup()
	else:
		$NeedMoneyPopup/VBoxContainer/Label.text = "You don't have enough money to buy this!\nYou need: " + str(round(GlobalRoomManager.get_current_room_price())) + "$"
		$NeedMoneyPopup.popup()

func _on_BuyConfirm_confirmed():
	GlobalRoomManager.buy_current_room()
	set_current_level(GlobalRoomManager.current_room)


func _on_ClosePopup_pressed():
	$NeedMoneyPopup.hide()
