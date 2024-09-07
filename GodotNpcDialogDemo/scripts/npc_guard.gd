extends Npc
class_name NpcGuard

#region METHOD - NATIVE
func _ready() -> void:
	super()
	
	# signals
	SignalManager.guard_keys_returned.connect(handle_guard_keys_returned)
#endregion
	
#region METHOD - SIGNAL
func handle_guard_keys_returned() -> void:
	# state
	set_current_state(NPC_STATE.CELEBRATE)
#endregion
