extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene # after : it's type of PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0

func _ready():
	base_spawn_time = timer.wait_time
	# to get the timer you use $Timer. (then the call you want)
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
	
func on_timer_timeout():
	# timer.start() is change the wait time in func on_area_difficulty_increased():
	# then it will update on the next timeout signal.
	timer.start()
	# Spawn the enemy outside the view of the player is what we are going for
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: return
	
	# pick a random spot around the player, out of view
	# get a random pos first with 0 to TAU (2 pi, or 360)
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	# spawn enemy and add it to the parent of the enemy manager in main
	var enemy = basic_enemy_scene.instantiate() as Node2D
	
	# tell it what parent you want to add it too
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position
	
# increase 
func on_arena_difficulty_increased(arena_difficlty: int):
	var time_off = (.1 /12) * arena_difficlty
	# if time_off exceeded .7 - clamp it at .7 
	time_off = min(time_off, .7) 
	print(time_off)
	timer.wait_time = base_spawn_time - time_off
	


