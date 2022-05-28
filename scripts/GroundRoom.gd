extends Spatial

const windmill_scene = preload("res://scenes/machines/Windmill.tscn")
const wind_turbine_scene = preload("res://scenes/machines/WindTurbine.tscn")
const solar_panel_scene = preload("res://scenes/machines/SolarPanel.tscn")
const solar_panel_mk2_scene = preload("res://scenes/machines/SolarPanelMk2.tscn")
const oil_gen_scene = preload("res://scenes/machines/OilGenerator.tscn")

onready var generator_pos = $BuildingPos

export(Resource) var room_info

export(Resource) var current_product

func _ready():
	pass

func can_spawn_product(pr: Product) -> bool:
	if current_product == null:
		return true
	
	if pr.product_class != current_product.product_class:
		return true
	
	if int(pr.tier) > int(current_product.tier):
		return true
	
	return false

func spawn_product(product: Product):
	if current_product != null:
		GlobalValues.power_usage -= current_product.power_usage
	current_product = product
	GlobalValues.power_usage = GlobalValues.power_usage + current_product.power_usage
	Utils.delete_children(generator_pos)
	if product.product_class == "wind":
		if product.tier == Product.Tier.Basic:
			var _node = Utils.instance_node(windmill_scene, generator_pos)
		else:
			var _node = Utils.instance_node(wind_turbine_scene, generator_pos)
	elif product.product_class == "solar":
		if product.tier == Product.Tier.Basic:
			var _node = Utils.instance_node(solar_panel_scene, generator_pos)
		else:
			var _node = Utils.instance_node(solar_panel_mk2_scene, generator_pos)
	else:
		var _node = Utils.instance_node(oil_gen_scene, generator_pos)
