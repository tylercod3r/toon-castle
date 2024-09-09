extends Npc
class_name NpcGuard

#region METHOD - NATIVE
func _ready() -> void:
	super()

	# signals
	SignalManager.guard_spoken_to.connect(handle_spoken_to)
	SignalManager.guard_end_spoken_to.connect(handle_end_spoken_to)
	SignalManager.guard_keys_returned.connect(handle_quest_item_returned)
#endregion
