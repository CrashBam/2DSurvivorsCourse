extends Node

signal arena_difficulty_increased(arena_difficulty: int)

const DIFFICULTY_INTERVAL = 5

@export var end_screen_scene: PackedScene

@onready var timer = $Timer

var arean_difficulty = 0

func _ready():
	timer.timeout.connect(on_timer_timeout)


func _process(delta):
	# the target goes down 5 sec everytime arean_difficulty goes up by 1 
	var next_time_target = timer.wait_time - ((arean_difficulty +1) * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_time_target:
		arean_difficulty += 1
		arena_difficulty_increased.emit(arean_difficulty)
		


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	# call the sfx, no need to send false as it's set by default
	end_screen_instance.play_jingle()
	MetaProgression.save() # save data
