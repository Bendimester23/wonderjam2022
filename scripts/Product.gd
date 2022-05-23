extends Resource
class_name Product

enum Category {
	Miner,
	Generator,
	Storage,
	Pumps
}

export(String) var label = "Basic Miner"
export(Texture) var icon
export(String) var buy_btn_text = "$69"
export(Texture) var buy_icon
export(Category) var category = Category.Miner
export(float) var multiplier = 1.0
export(float) var price = 69
