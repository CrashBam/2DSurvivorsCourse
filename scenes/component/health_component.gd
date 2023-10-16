extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10

var current_health
	

func _ready():
	current_health = max_health
	
func damage(damage_amount: float):
	current_health = max(current_health - damage_amount, 0)
	health_changed.emit() # TODO refactor later when player can re heal
	Callable(check_death).call_deferred()
	
func get_health_percent():
	if max_health <= 0:
		return
	# make sure we can't have a number greater then 1
	return min(current_health / max_health, 1) 


func  check_death():
	if current_health == 0:
		died.emit()
		# owner is the node that constitute the root of the scene
		#that this node exist in and free it. 
		owner.queue_free() 
