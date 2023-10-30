extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D
@onready var random_audio_stream_player_2d_component = $RandomAudioStreamPlayer2DComponent


func _ready():
	$Area2D.area_entered.connect(on_area_entered)


func tween_collect(percent: float, start_position : Vector2):
	var player = get_tree().get_first_node_in_group("player") 
	if player == null:
		return
		
	global_position = start_position.lerp(player.global_position, percent)
	var direction_from_start = player.global_position - start_position
	
	# Set off set
	var target_rotation =  direction_from_start.angle() + deg_to_rad(90)
	# Frame independent smooth lerp
	rotation = lerp_angle(rotation, target_rotation, 1 - exp(-2 * get_process_delta_time()))


func collect():
	GameEvents.emit_experience_vial_collected(1) # number of ex points for this vial
	queue_free()


func disable_collision():
	collision_shape_2d.disabled = true



func on_area_entered(other_area: Area2D):
	# Can't diable collision on a on enter so this is a work around
	Callable(disable_collision).call_deferred() # call on the next idel frame
	
	# Create a tween to fly to player on pickup
	var tween = create_tween()
	# set all the tweens will run all the tweens in paral
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, .5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ZERO, .55).set_delay(.45)
	# chain will wait from previous tweens then finish
	tween.chain()
	tween.tween_callback(collect)
	
	random_audio_stream_player_2d_component.play_random()
	
	


