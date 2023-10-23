extends Node2D

@export var health_component: Node
@export var sprite: Sprite2D

func _ready():
	$GPUParticles2D.texture = sprite.texture
	health_component.died.connect(on_died)
	
	
func on_died():
	# get the owners global pos
	if owner == null || not owner is Node2D:
		return
		
	var spawn_position = owner.global_position
	
	# get the entitys layer
	var entities = get_tree().get_first_node_in_group("entities_layer")
	# get parent and remove myself
	get_parent().remove_child(self)
	entities.add_child(self)
	
	# set our pos
	global_position = spawn_position
	
	# play animation die
	$AnimationPlayer.play("default")
	
