extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer

func _ready():
	get_tree().paused = true # pause game
	

# pass in an array of ability upgrades to display on the update screen
func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	var delay = 0
	# create a card for each upgrade
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		# play card animation pop up
		card_instance.play_in(delay)
		# making sure we connect each card selected (click it) signal and also binding upgrade we are currently looking at
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))
		delay += .2
		
# when the signal is emited then we send the upgrade_selected(upgrade: AbilityUpgrade)
func on_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	get_tree().paused = false # un-pause game
	queue_free()
	# why are we doing a nested select
	# we want each to have it's own responsibility
	# the card is is only responsible for detecting the click and displaying data
	# the Upgrade Screen - displaying all the abilitys that were supplyed or chosen
	
