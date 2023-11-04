extends Node


@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer


func _ready():
	animation_player.play("start_logo")


func _on_animation_player_animation_finished(anim_name):
	print(anim_name + " - add more stuff here")
	timer.start()
	


func _on_timer_timeout():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
