extends CanvasLayer

signal transitioned_halfway

@onready var animation_player = $AnimationPlayer


var skip_emit = false


func transition():
	$ColorRect.visible = true
	animation_player.play("default")
	await animation_player.animation_finished
	transitioned_halfway.emit()
	animation_player.play_backwards("default")
	await animation_player.animation_finished
	$ColorRect.visible = false


func emit_transitioned_halfway():
	# skip the signal on backwards
	if skip_emit:
		skip_emit = false
		return
	transitioned_halfway.emit()

