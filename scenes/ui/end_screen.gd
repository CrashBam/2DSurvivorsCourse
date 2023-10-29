extends CanvasLayer

@onready var panel_container = %PanelContainer


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
	%RestartButton.pressed.connect(on_restart_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func set_defeat():
	%TitleLabel.text = "Defeat"
	%DescriptionLabel.text = "You lost!"


func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_quit_pressed():
	get_tree().quit()
	


