extends Spatial

const windmill_scene = preload("res://scenes/machines/Windmill.tscn")
const wind_turbine_scene = preload("res://scenes/machines/WindTurbine.tscn")
const solar_panel_scene = preload("res://scenes/machines/SolarPanel.tscn")
const solar_panel_mk2_scene = preload("res://scenes/machines/SolarPanelMk2.tscn")
const oil_gen_scene = preload("res://scenes/machines/OilGenerator.tscn")

onready var generator_pos = $BuildPos

export(Resource) var room_info setget refresh

export(Resource) var current_product

func refresh(new):
	room_info = new
	if room_info.locked:
		$LockedIcon.show()
	else:
		$LockedIcon.hide()

func can_spawn_product(pr: Product) -> bool:
	if current_product == null:
		return true
	
	if pr.product_class != current_product.product_class:
		return true
	
	if int(pr.tier) > int(current_product.tier):
		return true
	
	return false

func calc_power() -> float:
	if current_product.product_class == "solar":
		return round((room_info.sun_value / 100) * current_product.power_usage)
	elif current_product.product_class == "wind":
		return round((room_info.wind_value / 100) * current_product.power_usage)
	elif current_product.product_class == "oil-gen":
		### Check if we have oil and water
		return current_product.power_usage
	return current_product.power_usage

func spawn_product(product: Product):
	if current_product != null:
		GlobalValues.power_usage -= calc_power()
	current_product = product
	GlobalValues.power_usage = GlobalValues.power_usage + calc_power()
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
