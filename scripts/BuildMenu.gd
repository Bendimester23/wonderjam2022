extends TabContainer

export(Array, Resource) var products = []

onready var miners_cont = $Miners/ScrollContainer/HBoxContainer
onready var storage_cont = $Storage/ScrollContainer/HBoxContainer
onready var power_gen_cont = $PowerGeneration/ScrollContainer/HBoxContainer
onready var pumps_cont = $Pumps/ScrollContainer/HBoxContainer

const product_card = preload("res://scenes/parts/hud/BuildIcon.tscn")

func _ready():
	refresh()

func _on_product_bought(product: Product) -> void:
	print(product.label)
	GlobalValues.money -= product.price
	GlobalRoomManager.room_nodes[GlobalRoomManager.current_room].spawn_product(product)
	
	# very bad practice, but why not
	refresh()

func can_buy(product: Product) -> bool:
	if GlobalValues.money < product.price:
		return false
	
	# there are no ores in the sky
	# also no oil(sorry US)
	if (product.category == Product.Category.Miner or product.category == Product.Category.Pumps) and GlobalRoomManager.get_room_info().type != RoomInfo.Type.Cave:
		return false
	
	# solar panels won't work in the caves
	# nor do wind turbines
	if product.category == Product.Category.Generator and GlobalRoomManager.get_room_info().type == RoomInfo.Type.Cave:
		return false
	
	return true

func can_build_here(p: Product) -> bool:
	# probably it haven't initialized yet
	if len(GlobalRoomManager.room_nodes) < 10:
		return true
	
	return GlobalRoomManager.room_nodes[GlobalRoomManager.current_room].can_spawn_product(p)

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
			node.can_buy = can_buy(product) and can_build_here(product)
			node.connect("bought", self, "_on_product_bought")
		elif product.category == Product.Category.Generator:
			var node = Utils.instance_node(product_card, power_gen_cont)
			node.product = product
			node.can_buy = can_buy(product) and can_build_here(product)
			node.connect("bought", self, "_on_product_bought")
		elif product.category == Product.Category.Storage:
			var node = Utils.instance_node(product_card, storage_cont)
			node.product = product
			node.can_buy = can_buy(product) and can_build_here(product)
			node.connect("bought", self, "_on_product_bought")
		else:
			var node = Utils.instance_node(product_card, pumps_cont)
			node.product = product
			node.can_buy = can_buy(product) and can_build_here(product)
			node.connect("bought", self, "_on_product_bought")

func _on_BuildMenu_visibility_changed():
	refresh()
