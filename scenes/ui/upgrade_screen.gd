extends CanvasLayer

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer

# pass in an array of ability upgrades to display on the update screen
func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		
		
