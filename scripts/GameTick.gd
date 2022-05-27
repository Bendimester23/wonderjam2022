extends Timer

export(float) var energy_price = 0.05

func _ready():
	connect("timeout", self, "_game_tick")

func _game_tick():
	GlobalValues.money -= GlobalValues.power_usage * energy_price
	
	### Add things to the Inventory
	Inventory.oil += GlobalValues.oil_rate
	Inventory.water += GlobalValues.water_rate
	
	Inventory.coal += GlobalValues.coal_rate
	Inventory.iron += GlobalValues.iron_rate
	Inventory.gems += GlobalValues.gems_rate
	
	### After everything
	Inventory.emit_signal("changed")
	
