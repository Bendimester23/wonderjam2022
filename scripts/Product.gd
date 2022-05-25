extends Resource
class_name Product

enum Category {
	Miner,
	Generator,
	Storage,
	Pumps
}

enum Tier {
	Basic = 0,
	Advanced = 1,
	Expert = 2
}

export(String) var label = "Basic Miner"
export(Texture) var icon
export(String) var buy_btn_text = "$69"
export(Texture) var buy_icon
export(Category) var category = Category.Miner
export(float) var multiplier = 1.0
export(float) var price = 69
export(String) var product_class
export(Tier) var tier
export(float) var power_usage
