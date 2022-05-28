extends Spatial

const miner_scene = preload("res://scenes/machines/Miner.tscn")
const adv_miner_scene = preload("res://scenes/machines/AdvancedMiner.tscn")
const the_drill_scene = preload("res://scenes/machines/TheDrill.tscn")

const water_pump = preload("res://scenes/machines/WaterPump.tscn")
const oil_pump = preload("res://scenes/machines/OilPump.tscn")
const water_rig = preload("res://scenes/machines/WaterRig.tscn")
const oil_rig = preload("res://scenes/machines/OilRig.tscn")

onready var miner_pos = $MinerPos

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
	if product.product_class == "miner":
		if product.tier == Product.Tier.Basic:
			Utils.instance_node(miner_scene, miner_pos)
		elif product.tier == Product.Tier.Advanced:
			Utils.instance_node(adv_miner_scene, miner_pos)
		else:
			Utils.instance_node(the_drill_scene, miner_pos)
	elif product.product_class == "water":
		if product.tier == Product.Tier.Basic:
			Utils.instance_node(water_pump, miner_pos)
		else:
			Utils.instance_node(water_rig, miner_pos)
	else:
		if product.tier == Product.Tier.Basic:
			Utils.instance_node(oil_pump, miner_pos)
		else:
			Utils.instance_node(oil_rig, miner_pos)
