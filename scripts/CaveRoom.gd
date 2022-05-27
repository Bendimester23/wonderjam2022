extends Spatial

const miner_scene = preload("res://scenes/machines/Miner.tscn")

onready var miner_pos = $MinerPos

export(Resource) var room_info setget refresh

export(Resource) var current_product

func refresh(new):
	room_info = new
	if room_info.locked:
		$LockedIcon.show()
	else:
		$LockedIcon.show()

func can_spawn_product(pr: Product) -> bool:
	if current_product == null:
		return true
	
	if pr.product_class != current_product.product_class:
		return true
	
	if int(pr.tier) > int(current_product.tier):
		return true
	
	return false

func calc_power() -> float:
	return current_product.power_usage

func add_resource_rate(mul):
	if current_product.category == Product.Category.Miner:
		GlobalValues.coal_rate += mul * room_info.coal_value / 10 * current_product.multiplier
		if current_product.tier == Product.Tier.Expert || current_product.tier == Product.Tier.Advanced:
			GlobalValues.iron_rate += mul * room_info.iron_value / 10 * current_product.multiplier
		if current_product.tier == Product.Tier.Expert:
			GlobalValues.gems_rate += mul * room_info.gem_value / 10 * current_product.multiplier
	elif current_product.category == Product.Category.Pumps:
		### TODO: make oil pumps only pupm out water and vice versa
		if current_product.product_class == "water":
			GlobalValues.water_rate += mul * room_info.water_value / 10 * current_product.multiplier
		if current_product.product_class == "oil":
			GlobalValues.oil_rate += mul * room_info.oil_value / 10 * current_product.multiplier

func spawn_product(product: Product):
	if current_product != null:
		GlobalValues.power_usage -= calc_power()
		add_resource_rate(-1)
	current_product = product
	GlobalValues.power_usage = GlobalValues.power_usage + calc_power()
	add_resource_rate(1)
	Utils.delete_children(miner_pos)
	Utils.instance_node(miner_scene, miner_pos)
