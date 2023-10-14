extends PanelContainer

@onready var name_lable: Label = $VBoxContainer/NameLabel
@onready var description_lable: Label = $VBoxContainer/DescriptionLabel

func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_lable.text = upgrade.name
	description_lable.text = upgrade.description
	

