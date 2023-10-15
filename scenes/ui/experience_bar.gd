extends CanvasLayer

@export var experience_manager: Node
@onready var progress_bar = %ProgressBar

func _ready():
	progress_bar.value = 0
	experience_manager.experience_updated.connect(on_experience_updated)
	
	
func on_experience_updated(current_experience: float, target_experience: float):
	# my code, checking if it's not 0
	if target_experience == 0:
		return
		
	var percent = current_experience / target_experience 
	progress_bar.value = percent
