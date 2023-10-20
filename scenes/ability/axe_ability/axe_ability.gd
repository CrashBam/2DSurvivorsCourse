extends Node2D

const MAX_RADIUS = 100 # As far as can be away from the player

@onready var hitbox_component = $HitBoxComponent


func _ready():
	# tweening the axe over time
	var tween = create_tween()
	# We are setting the tween, we are telling the tween
	# we want to go from the value 0 and 2 over 3 sec, when your doing that
	# we are calling the func tween_method
	tween.tween_method(tween_method, 0.0, 2.0, 3)
	# After tween is finished call a func
	tween.tween_callback(queue_free) # free the axe for us
	
	
func tween_method(rotations: float):
	var percent = rotations / 2
	# we get the percent so we can cal the radius should be from 0 to MAX_RADIUS
	var current_radius = percent * MAX_RADIUS
	# take the number of rotations that we are multiply by TAU use that as a rotation
	# apply to the RIGHT vector, RIGHT vec is at 0 degrees
	var current_direction = Vector2.RIGHT.rotated(rotations * TAU)
	
	
	# How to position the axe?
	var player = get_tree().get_first_node_in_group("player") 
	if player == null:
		return
	# Move the axe around the player
	global_position = player.global_position + (current_direction * current_radius)
