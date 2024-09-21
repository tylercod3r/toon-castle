extends Node

#region VARIABLE
@export var keys:Node3D
@export var keys_particle_parent:Node3D

@export var cheese:Node3D
@export var cheese_particle_parent:Node3D

@export var bottle:Node3D
@export var bottle_particle_parent:Node3D
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	SignalManager.guard_keys_found.connect(handle_keys_found)
	SignalManager.cheese_found.connect(handle_cheese_found)
	SignalManager.bottle_found.connect(handle_bottle_found)
#endregion

#region METHOD - SIGNAL
func handle_keys_found() -> void:
	#TODO - investigate why this signal gets received twice
	#print("keys found....")
	
	if keys:
		keys.visible = false
		(keys_particle_parent.get_child(0) as GPUParticles3D).set_emitting(true)

func handle_cheese_found() -> void:
	#TODO - investigate why this signal gets received twice
	#print("cheese found....")
	
	if cheese:
		cheese.visible = false
		(cheese_particle_parent.get_child(0) as GPUParticles3D).set_emitting(true)
		
func handle_bottle_found() -> void:
	#TODO - investigate why this signal gets received twice
	#print("bottle found....")
	
	if bottle:
		bottle.visible = false
		(bottle_particle_parent.get_child(0) as GPUParticles3D).set_emitting(true)
#endregion
