extends Node
class_name SplashScreen

signal end_splash_screen


@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_swoosh = $AudioStreamPlayer2DSwoosh


func _ready():
	animation_player.play("start_logo")
	end_splash_screen.connect(on_end_splash_screen)

func _input(event):
	if(event is InputEventKey):
		end_splash_screen.emit()
		_on_timer_timeout()


func on_end_splash_screen():
	pass


func play_sound_sfx():
	audio_player.play()


func play_swoosh_sfx():
	audio_stream_player_2d_swoosh.play()

func _on_animation_player_animation_finished(anim_name):
	print(anim_name + " - add more stuff here")
	timer.start()
	


func _on_timer_timeout():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	end_splash_screen.emit()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
