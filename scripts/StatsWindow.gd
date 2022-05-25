extends ColorRect

onready var wind_val = $Values/Wind
onready var sun_val = $Values/Sun

onready var water_val = $Values/Water
onready var oil_val = $Values/Oil

onready var coal_val = $Values/Coal
onready var iron_val = $Values/Iron
onready var gems_val = $Values/Gems

func refresh() -> void:
	var info = GlobalRoomManager.get_room_info()
	
	wind_val.value = info.wind_value
	sun_val.value = info.sun_value
	
	water_val.value = info.water_value
	oil_val.value = info.oil_value
	
	coal_val.value = info.coal_value
	iron_val.value = info.iron_value
	gems_val.value = info.gem_value
	
