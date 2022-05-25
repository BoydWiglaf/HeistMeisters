extends NinePatchRect

func _ready():
	hide()

func collected_loot():
	show()
	$VBoxContainer/LootCounter.add_item("", load("res://GFX/Loot/suitcase.png"), false)
