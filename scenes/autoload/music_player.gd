extends AudioStreamPlayer

@onready var timer = $Timer

func _ready():
	finished.connect(on_finished)
	timer.timeout.connect(on_timer_timeout)
	
	MySignals.SplashScreenEnded.connect(on_splashscreen_ended)


func on_splashscreen_ended():
	play()


func on_finished():
	timer.start()


func on_timer_timeout():
	play()

