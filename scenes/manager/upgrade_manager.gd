extends Node

@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}
var upgrade_pool: WeightedTable = WeightedTable.new()

var upgrade_axe = preload("res://resources/upgrades/axe.tres")
var upgrade_axe_damage = preload("res://resources/upgrades/axe_damage.tres")
var upgrade_sword_rate = preload("res://resources/upgrades/sword_rate.tres")
var upgrade_sword_damage = preload("res://resources/upgrades/sword_damage.tres")
var upgrade_player_speed = preload("res://resources/upgrades/player_speed.tres")

func _ready():
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	upgrade_pool.add_item(upgrade_player_speed, 5)
	
	
	experience_manager.level_up.connect(on_level_up)
	

# pool filitering
func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade, 
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	# give us the current quantity after we apply the upgrade
	if upgrade.max_quantity > 0:
		# give us the current quantity after we apply the upgrade
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		# then filter and return 
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)
			
	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades) 


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)
	# add more here
	
	
	

func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []

	for i in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		# chosen_upgrade will return every upgrade in the list does not share id of the chosen upgrade
		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades) 
		chosen_upgrades.append(chosen_upgrade)

	
	return chosen_upgrades


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
	
	
func on_level_up(current_level: int):
	# we instantiate and add it as a child 
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	# we tell it, these are the upgrades to show
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	# listening for a click, if so call (on_upgrade_selected)
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)

