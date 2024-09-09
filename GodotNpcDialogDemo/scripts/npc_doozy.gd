extends Npc
class_name NpcDoozy

#region METHOD - NATIVE
func _ready() -> void:
	super()

	# signals
	SignalManager.doozy_spoken_to.connect(handle_spoken_to)
	SignalManager.doozy_end_spoken_to.connect(handle_end_spoken_to)
	SignalManager.bottle_returned.connect(handle_quest_item_returned)
#endregion
