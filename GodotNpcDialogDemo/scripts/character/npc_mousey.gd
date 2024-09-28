extends Npc
class_name NpcMousey

#region METHOD - NATIVE
func _ready() -> void:
	super()

	# signals
	SignalManager.mousey_spoken_to.connect(handle_spoken_to)
	SignalManager.mousey_end_spoken_to.connect(handle_end_spoken_to)
	SignalManager.cheese_returned.connect(handle_quest_item_returned)
#endregion
