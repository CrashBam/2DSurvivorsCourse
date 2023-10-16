extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var decription_label: Label = %DescriptionLabel

func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	decription_label.text = upgrade.description
	
