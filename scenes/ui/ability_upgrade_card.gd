extends PanelContainer

signal selected

@onready var name_label: Label = %NameLabel
@onready var decription_label: Label = %DescriptionLabel

var disable = false

func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)


func play_in(delay: float = 0):
	modulate = Color.TRANSPARENT
	await  get_tree().create_timer(delay).timeout # wait
	$AnimationPlayer.play("in")
	

func play_discard():
	$AnimationPlayer.play("discard")


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	decription_label.text = upgrade.description

func select_card():
	disable = true
	$AnimationPlayer.play("selected")
	
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_discard()
	
	await $AnimationPlayer.animation_finished
	selected.emit()
	
	# This func will fire if the gui detects left click on mouse
	# and fire off the signal, things listening will run there func's
func on_gui_input(event: InputEvent):
	if disable:
		return
	if event.is_action_pressed("left_click"):
		select_card()


func  on_mouse_entered():
	if disable:
		return
	$HoverAnimationPlayer.play("hover")
