extends Spatial

const miner_scene = preload("res://scenes/machines/Miner.tscn")

onready var generator_pos = $BuildPos

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
	Utils.instance_node(miner_scene, generator_pos)
