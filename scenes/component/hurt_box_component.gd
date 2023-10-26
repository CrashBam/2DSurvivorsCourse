extends Area2D
class_name HurtboxComponent

@export var health_component: Node

var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")

func _ready():
	area_entered.connect(on_area_entered)
	

func on_area_entered(other_area: Area2D):
	if not other_area is HitBoxComponent:
		return
	
	if health_component == null:
		return
	
	var hitbox_component = other_area as HitBoxComponent
	# get the damage from the hitbox component and apply damage 
	health_component.damage(hitbox_component.damage) 
	
	# instantiate text
	var floating_text = floating_text_scene.instantiate() as Node2D
	# set node2d to foreground layer
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	#set pos to the center of the enemy
	floating_text.global_position = global_position + (Vector2.UP * 16)
	# format the string for no dec
	#var format_string = "%0.1f"
	var format_string = "%0.0f"
	#if round(hitbox_component.damage) == hitbox_component.damage:
	#	format_string = "%0.0f"
	# pass in the damage into the text string
	floating_text.start(format_string % (hitbox_component.damage))
