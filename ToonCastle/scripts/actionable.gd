extends Area3D

const Balloon = preload("res://dialog/balloon.tscn")

@export var dialogue_resource:DialogueResource
@export var dialogue_start:String = "start"
@onready var portrait: TextureRect = %Portrait

func action() -> void:
	notify_npc(self.get_parent().name)
	
	var balloon:Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)

func notify_npc(node_name:String) -> void:
	# TODO: find less brittle method for id lookup
	match node_name:
		'NPC_Guard':
			SignalManager.handleGuardSpokenTo()
		'NPC_Mousey':
			SignalManager.handleMouseySpokenTo()
		'NPC_Doozy':
			SignalManager.handleDoozySpokenTo()


func _on_area_exited(area: Area3D) -> void:
	print('exittttt')
