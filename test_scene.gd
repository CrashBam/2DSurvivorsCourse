extends Node

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

@export var pause_time: float = 1

func _ready():
	# Connect the animation_finished signal to your custom function
	animation_player.connect("animation_finished", self, "_on_animation_finished")

	# Start playing the "start_logo" animation
	animation_player.play("start_logo")

# This function is called when the "start_logo" animation finishes
func _on_animation_finished(anim_name):
	if anim_name == "start_logo":
		# Pause for the specified time
		timer.wait_time = pause_time
		timer.start()

# This function is called when the Timer's time is up
func _on_Timer_timeout():
	# Reverse the animation playback
	animation_player.play_backwards("start_logo")

	# Use the 'when_done' argument of play_backwards to call the function when the animation is done playing backward
	animation_player.play_backwards("start_logo", 0.0, 1.0, true, true, self, "_on_animation_finished_backward")

# This function is called when the "start_logo" animation finishes playing backward
func _on_animation_finished_backward(anim_name):
	if anim_name == "start_logo":
		load_main_menu()

func load_main_menu():
	get_tree().change_scene("res://scenes/ui/main_menu.tscn")
