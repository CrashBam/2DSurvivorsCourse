extends CanvasLayer

@onready var panel_container = %PanelContainer
@onready var victory_stream_player = $VictoryStreamPlayer
@onready var defeat_stream_player = $DefeatStreamPlayer


func _ready():
	# set pivot off set 1/2 height, 1/2 width = center
	panel_container.pivot_offset = panel_container.size / 2
	# create tween to be played
	var tween = create_tween()
	# we reset to Zero, godot work around
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	get_tree().paused = true
	%ContinueButton.pressed.connect(on_continue_button_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func set_defeat():
	%TitleLabel.text = "Defeat"
	%DescriptionLabel.text = "You lost!"
	play_jingle(true)
	


func play_jingle(defeat: bool = false):
	if defeat:
		defeat_stream_player.play()
	else:
		victory_stream_player.play()


func on_continue_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/meta_menu.tscn")


func on_quit_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/main_menu.tscn")
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
	


