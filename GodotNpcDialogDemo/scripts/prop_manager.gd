extends Node

#region VARIABLE
@export var guard_keys:Node3D
@export var cheese:Node3D
@export var bottle:Node3D
#@export var points_of_interest:Array[Node3D] = []
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	SignalManager.guard_keys_found.connect(handle_guard_keys_found)
	SignalManager.cheese_found.connect(handle_cheese_found)
	SignalManager.bottle_found.connect(handle_bottle_found)
#endregion

#region METHOD - SIGNAL
func handle_guard_keys_found() -> void:
	#TODO - investigate why this signal gets received twice
	#print("guard keys found....")
	
	if guard_keys:
		guard_keys.visible = false
		
func handle_cheese_found() -> void:
	#TODO - investigate why this signal gets received twice
	#print("cheese found....")
	
	if cheese:
		cheese.visible = false
		
func handle_bottle_found() -> void:
	#TODO - investigate why this signal gets received twice
	#print("bottle found....")
	
	if bottle:
		bottle.visible = false
#endregion
