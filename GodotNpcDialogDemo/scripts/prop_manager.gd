extends Node

#region VARIABLE
@export var guard_keys:Node3D
#@export var points_of_interest:Array[Node3D] = []
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	SignalManager.guard_keys_found.connect(handle_guard_keys_found)
#endregion

#region METHOD - SIGNAL
func handle_guard_keys_found() -> void:
	#TODO - investigate why this signal gets received twice
	#print("guard keys found....")
	
	if guard_keys:
		guard_keys.visible = false
#endregion
