extends Npc
class_name NpcMousey

#region METHOD - NATIVE
func _ready() -> void:
	super()
	
	# signals
	SignalManager.cheese_returned.connect(handle_cheese_returned)
#endregion
	
#region METHOD - SIGNAL
func handle_cheese_returned() -> void:
	# state
	set_current_state(NPC_STATE.CELEBRATE)
#endregion
