extends Node

signal money_changed
signal power_usage_changed

export var allow_movement = true

export var power_usage = 0 setget power_changed_callback

export var current_floor_type = RoomInfo.Type.Ground

# TODO: move this to somewhere
export var money = 6969 setget money_changed_hook

func power_changed_callback(new) -> void:
	power_usage = new
	emit_signal("power_usage_changed")

func money_changed_hook(new): 
	money = new
	emit_signal("money_changed")
