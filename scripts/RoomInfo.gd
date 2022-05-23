extends Resource
class_name RoomInfo

enum Type {
	Air = 0,
	Ground = 1,
	Cave = 2
}

export(Type) var type = Type.Air
export(bool) var locked = false

# Natural resources
export(float) var oil_value = 0.0
export(float) var water_value = 0.0
export(float) var wind_value = 0.0
export(float) var sun_value = 0.0
# Ores
export(float) var coal_value = 0.0
export(float) var iron_value = 0.0
export(float) var gem_value = 0.0

func _init(p_locked = false):
	locked = p_locked
