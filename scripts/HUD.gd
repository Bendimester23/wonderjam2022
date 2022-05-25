extends Control

onready var level_label = $Level/Label
onready var stats_window = $StatsWindow
onready var build_menu = $BuildMenu

var stats_window_shown = false
var build_menu_shown = false

func _process(delta):
	if is_something_open() and Input.is_action_just_pressed("ui_cancel"):
		stats_window.hide()
		build_menu.hide()
		stats_window_shown = false
		build_menu_shown = false
		GlobalValues.allow_movement = true

func is_something_open() -> bool:
	return stats_window_shown or build_menu_shown

func set_current_level(num: int) -> void:
	GlobalValues.current_floor_type = GlobalRoomManager.get_room_info().type
	level_label.text = str(num)

func _on_StatsButton_pressed():
	if stats_window_shown:
		stats_window.hide()
		stats_window_shown = false
		GlobalValues.allow_movement = true
		return
	stats_window.show()
	stats_window_shown = true
	GlobalValues.allow_movement = false
	stats_window.refresh()

func _ready():
	GlobalValues.connect("money_changed", self, "_on_money_changed")
	GlobalValues.connect("power_usage_changed", self, "_on_power_usage_changed")
	_on_money_changed()

func _on_money_changed():
	$BottomBar/Money.text = str(GlobalValues.money) + "$"

func _on_power_usage_changed():
	$BottomBar/PowerUsage.text = str(GlobalValues.power_usage) + "kW/h"

func _on_Build_pressed():
	if !build_menu_shown:
		build_menu.show()
		build_menu_shown = true
		GlobalValues.allow_movement = false
	else:
		build_menu.hide()
		build_menu_shown = false
		GlobalValues.allow_movement = true
