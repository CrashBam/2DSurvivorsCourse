extends Node

var main_menu_scene = preload("res://scenes/ui/main_menu.tscn")

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer

@export var pause_time: float = 1

func _ready():
	# Start playing the "start_logo" animation
	animation_player.play("start_logo")

	# Connect the Timer's timeout signal to the load_main_menu function
	#timer.connect("timeout", self, "load_main_menu")

	# Set the Timer's wait time to the desired pause_time
	#timer.wait_time = pause_time
	#timer.start()
	
# This function is called when it's time to load the main menu
func load_main_menu():
	print("Load main menu called")
	#var main_menu_instance = main_menu_scene.instance()
	#get_tree().get_root().add_child(main_menu_instance)

