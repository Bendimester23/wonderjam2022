extends Spatial

const miner_scene = preload("res://scenes/machines/Miner.tscn")

onready var miner_pos = $MinerPos

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
	Utils.delete_children(miner_pos)
	Utils.instance_node(miner_scene, miner_pos)
