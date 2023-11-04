extends AudioStreamPlayer
class_name MusicPlayerNodeClass

@onready var timer = $Timer
@onready var start_time_wait = $StartTimeWait


func _ready():
	finished.connect(on_finished)
	timer.timeout.connect(on_timer_timeout)
	
	start_time_wait.start()
	start_time_wait.timeout.connect(on_timer_timeout)


func _onEndSplashScreen():
	pass

func on_finished():
	timer.start()


func on_timer_timeout():
	play()
	start_time_wait.stop()
