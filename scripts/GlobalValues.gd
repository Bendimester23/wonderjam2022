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

### Resource mining & pumping section

signal resource_rates_changed

export var coal_rate = 0 setget coal_rate_callback
export var iron_rate = 0 setget iron_rate_callback
export var gems_rate = 0 setget gems_rate_callback

export var water_rate = 0 setget water_rate_callback
export var oil_rate = 0 setget oil_rate_callback

func coal_rate_callback(new) -> void:
	coal_rate = new
	emit_signal("resource_rates_changed")

func iron_rate_callback(new) -> void:
	iron_rate = new
	emit_signal("resource_rates_changed")

func gems_rate_callback(new) -> void:
	gems_rate = new
	emit_signal("resource_rates_changed")

func water_rate_callback(new) -> void:
	water_rate = new
	emit_signal("resource_rates_changed")

func oil_rate_callback(new) -> void:
	oil_rate = new
	emit_signal("resource_rates_changed")
