extends Area3D

const Balloon = preload("res://dialog/balloon.tscn")

@export var dialogue_resource:DialogueResource
@export var dialogue_start:String = "start"
@onready var portrait: TextureRect = %Portrait

func action() -> void:
	var balloon:Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
