extends Timer

export(float) var energy_price = 0.05

func _ready():
	connect("timeout", self, "_game_tick")

func _game_tick():
	print("tick")
	GlobalValues.money -= GlobalValues.power_usage * energy_price
