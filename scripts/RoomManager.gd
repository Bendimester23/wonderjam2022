extends Spatial

export(Array, Resource) var rooms = []
export(Array, Resource) var sky_rooms = []

onready var ground_room = preload("res://scenes/GroundRoom.tscn")
onready var cave_room = preload("res://scenes/CaveRoom.tscn")
onready var air_room = preload("res://scenes/SkyRoom.tscn")


onready var locked_room = preload("res://scenes/LockedRoom.tscn")

export(Curve) var wind_value_curve;
export(Curve) var sun_value_curve;

# Fluids
export(Curve) var oil_value_curve;
export(Curve) var water_value_curve;

# Ores
export(Curve) var coal_value_curve;
export(Curve) var iron_value_curve;
export(Curve) var gems_value_curve;

export var current_room = 0

func _ready() -> void:
	#TODO remove this when adding the main menu
	init_rooms()

func init_rooms() -> void:
	for i in range(1, 100):
		add_room(-i)
		add_sky_room(i)
	refresh_rooms()

func add_sky_room(floor_id) -> void:
	sky_rooms.append(generate_random_room(floor_id))

func add_room(floor_id) -> void:
	rooms.append(generate_random_room(floor_id))

func get_room_info() -> RoomInfo:
	return rooms[abs(current_room)]

func refresh_rooms() -> void:
	for n in get_children():
		n.queue_free()
	yield(get_tree(), "idle_frame")
	_place_rooms()

func _place_rooms() -> void:
	var i = 0
	for room in rooms:
		var r = room as RoomInfo
		if r.type == RoomInfo.Type.Ground:
			var instance = $"/root/Utils".instance_node(ground_room, self)
			instance.name = "Room #" + str(i)
		elif r.type == RoomInfo.Type.Cave:
			var instance = $"/root/Utils".instance_node_at_position(cave_room, self, Vector3(0, i*10+5, 0))
			instance.name = "Room #" + str(-i)
		i -= 1
	
	i = 0
	for sky_room in sky_rooms:
		var instance = $"/root/Utils".instance_node_at_position(air_room, self, Vector3(0, -(i*10-15), 0))
		instance.name = "Room #" + str(i)
		i -= 1

func generate_random_room(floor_id: float) -> RoomInfo:
	var info = RoomInfo.new()
	
	if floor_id == 0:
		info.type = RoomInfo.Type.Ground
	elif floor_id < 0:
		info.type = RoomInfo.Type.Cave
	else:
		info.type = RoomInfo.Type.Air
		
	### Calcualting natural resource values
	
	if floor_id >= 0:
		# Sun
		var median_sun_value = sun_value_curve.interpolate_baked(min(floor_id/100, 1.0))
		info.sun_value = rand_range(max(median_sun_value-.04, 0), min(median_sun_value+.04, 1))
		
		# Wind
		var median_wind_value = wind_value_curve.interpolate_baked(min(floor_id/100, 1.0))
		info.wind_value = rand_range(max(median_wind_value-.04, 0), min(median_wind_value+.04, 1))
	else:
		# Coal
		var median_coal_value = coal_value_curve.interpolate_baked(min(floor_id/100, 1.0))
		info.coal_value = rand_range(max(median_coal_value-.04, 0), min(median_coal_value+.04, 1))
		
		# Iron
		var median_iron_value = iron_value_curve.interpolate_baked(min(floor_id/100, 1.0))
		info.iron_value = rand_range(max(median_iron_value-.04, 0), min(median_iron_value+.04, 1))
		
		# Gems
		var median_gems_value = gems_value_curve.interpolate_baked(min(floor_id/100, 1.0))
		info.gem_value = rand_range(max(median_gems_value-.04, 0), min(median_gems_value+.04, 1))
		
		# Water
		var median_water_value = water_value_curve.interpolate_baked(min(floor_id/100, 1.0))
		info.water_value = rand_range(max(median_water_value-.04, 0), min(median_water_value+.04, 1))
		
		# Oil
		var median_oil_value = oil_value_curve.interpolate_baked(min(floor_id/100, 1.0))
		info.oil_value = rand_range(max(median_oil_value-.04, 0), min(median_oil_value+.04, 1))
	
	return info
