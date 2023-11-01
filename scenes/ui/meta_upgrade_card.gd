extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var decription_label: Label = %DescriptionLabel


func _ready():
	gui_input.connect(on_gui_input)


func set_meta_upgrade(upgrade: MetaUpgrade):
	name_label.text = upgrade.name
	decription_label.text = upgrade.description

func select_card():
	$AnimationPlayer.play("selected")


	# This func will fire if the gui detects left click on mouse
	# and fire off the signal, things listening will run there func's
func on_gui_input(event: InputEvent): 
	if event.is_action_pressed("left_click"):
		select_card()

