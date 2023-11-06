extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var decription_label: Label = %DescriptionLabel
@onready var progress_bar = %ProgressBar
@onready var purchase_button = %PurchaseButton
@onready var progress_label = %ProgressLabel

var upgrade: MetaUpgrade


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)
	gui_input.connect(on_gui_input)
	


func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	decription_label.text = upgrade.description
	update_progress()


func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent =  currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1 
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)
	

func select_card():
	$AnimationPlayer.play("selected")


	# This func will fire if the gui detects left click on mouse
	# and fire off the signal, things listening will run there func's
func on_gui_input(event: InputEvent): 
	if event.is_action_pressed("left_click"):
		select_card()


func on_purchase_pressed():
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
