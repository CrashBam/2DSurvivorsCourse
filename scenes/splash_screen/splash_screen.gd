extends Node
class_name SplashScreen


@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_swoosh = $AudioStreamPlayer2DSwoosh
@onready var logo_blinking_anim = $CenterContainer/VBoxContainer/LogoBlinkingAnim
@onready var logo_blink_sprite = $CenterContainer/VBoxContainer/LogoBlinkSprite


func _ready():
	animation_player.play("start_logo")
	logo_blinking_anim.hide()
	logo_blink_sprite.show()

func _input(event):
	if(event is InputEventKey):
		MySignals.SplashScreenEnded.emit()
		_on_timer_timeout()


func play_sound_sfx():
	audio_player.play()


func play_swoosh_sfx():
	audio_stream_player_2d_swoosh.play()


func _on_animation_player_animation_finished(anim_name):
	timer.start()
	logo_blink_sprite.hide()
	logo_blinking_anim.show()
	logo_blinking_anim.play("blinking")
	
	


func _on_timer_timeout():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	MySignals.SplashScreenEnded.emit()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
