extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene # after : it's type of PackedScene


func _ready():
	# to get the timer you use $Timer. (then the call you want)
	$Timer.timeout.connect(on_timer_timeout)
	
	
func on_timer_timeout():
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
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
	


