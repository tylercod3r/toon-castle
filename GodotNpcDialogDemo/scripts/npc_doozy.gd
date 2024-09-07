extends Npc
class_name NpcDoozy

#region METHOD - NATIVE
func _ready() -> void:
	super()
	
	# signals
	SignalManager.bottle_returned.connect(handle_bottle_returned)
#endregion
	
#region METHOD - SIGNAL
func handle_bottle_returned() -> void:
	# state
	set_current_state(NPC_STATE.CELEBRATE)
#endregion
