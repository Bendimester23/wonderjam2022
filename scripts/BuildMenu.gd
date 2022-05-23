extends TabContainer

export(Array, Resource) var products = []

onready var miners_cont = $Miners/ScrollContainer/HBoxContainer
onready var storage_cont = $Storage/ScrollContainer/HBoxContainer
onready var power_gen_cont = $PowerGeneration/ScrollContainer/HBoxContainer
onready var pumps_cont = $Pumps/ScrollContainer/HBoxContainer

const product_card = preload("res://scenes/parts/hud/BuildIcon.tscn")

func _ready():
	refresh()

func refresh():
	Utils.delete_children(miners_cont)
	Utils.delete_children(storage_cont)
	Utils.delete_children(power_gen_cont)
	Utils.delete_children(pumps_cont)
	for p in products:
		var product = p as Product
		if product.category == Product.Category.Miner:
			var node = Utils.instance_node(product_card, miners_cont)
			node.product = product
			node.can_buy = GlobalValues.current_floor_type == RoomInfo.Type.Cave and GlobalValues.money >= product.price
		elif product.category == Product.Category.Generator:
			var node = Utils.instance_node(product_card, power_gen_cont)
			node.product = product
			node.can_buy = GlobalValues.current_floor_type != RoomInfo.Type.Cave and GlobalValues.money >= product.price
		elif product.category == Product.Category.Storage:
			var node = Utils.instance_node(product_card, storage_cont)
			node.product = product
			node.can_buy = GlobalValues.current_floor_type == RoomInfo.Type.Ground and GlobalValues.money >= product.price
		else:
			var node = Utils.instance_node(product_card, pumps_cont)
			node.product = product
			node.can_buy = GlobalValues.current_floor_type == RoomInfo.Type.Cave and GlobalValues.money >= product.price


func _on_BuildMenu_visibility_changed():
	refresh()
