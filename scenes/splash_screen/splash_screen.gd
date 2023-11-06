extends Node
class_name SplashScreen


@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var animation_player_music = $AnimationPlayerMusic
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_stream_swooshFX = $AudioStreamPlayer2DSwoosh
@onready var audio_streambackground_music = $AudioStreamPlayer2DBackground
@onready var logo_blinking_anim = $CenterContainer/VBoxContainer/LogoBlinkingAnim
@onready var logo_blink_sprite = $CenterContainer/VBoxContainer/LogoBlinkSprite


func _ready():
	animation_player.play("start_logo")
	logo_blinking_anim.hide()
	logo_blink_sprite.show()
	animation_player_music.play("fade_music")
	audio_streambackground_music.play()

func _input(event):
	if(event is InputEventKey):
		MySignals.SplashScreenEnded.emit()
		_on_timer_timeout()


func play_sound_sfx():
	audio_player.play()


func play_swoosh_sfx():
	audio_stream_swooshFX.play()


func _on_animation_player_animation_finished(anim_name):
	timer.start()
	logo_blink_sprite.hide()
	logo_blinking_anim.show()
	logo_blinking_anim.play("blinking")
	
	


func _on_timer_timeout():
	play_swoosh_sfx()
	animation_player_music.play_backwards("fade_music")
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	MySignals.SplashScreenEnded.emit()
	audio_streambackground_music.stop()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
