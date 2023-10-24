extends Node2D



func _ready():
	pass

func start(text: String):
	$Label.text = text
	
	var tween = create_tween()
	# Set tween to run in parallel
	tween.set_parallel()
	# Start off slow
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

	# Now we wait tween.chain() = Wait till previous tween is done then contune
	tween.chain()
	# Speed up
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 48), .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	# scale the text AGAIN! :P
	tween.tween_property(self, "scale", Vector2.ONE, .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	# Now we wait tween.chain() = Wait till previous tween is done then contune
	tween.chain()
	
	# Kill tween after tween
	tween.tween_callback(queue_free)
	
	
	# scale the text
	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ONE * 1.5, .15)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, .15)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	scale_tween.tween_callback(queue_free)
	
