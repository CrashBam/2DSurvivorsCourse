extends Node

const SAVE_FILE_PATH = "user://game.save"

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}


func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_collected)
	load_save_file()



func load_save_file():
	if !FileAccess.file_exists(SAVE_FILE_PATH):
		return
	# get file
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	# set file
	save_data = file.get_var()


func save():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)


# What is this function doing?
# if we don't yet have an upgrade that we are passing in then
# what we are going to do is : set the entree to have a default val of 0
func add_meta_upgrade(upgrade: MetaUpgrade):
	if !save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}
		
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	save()
  

func on_experience_collected(number: float):
	save_data["meta_upgrade_currency"] += number
	
