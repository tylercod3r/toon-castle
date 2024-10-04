extends Node

#region VARIABLE
var remainingQuestCompletionCount:int = 3
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	SignalManager.guard_keys_returned.connect(handle_quest_completed)
	SignalManager.cheese_returned.connect(handle_quest_completed)
	SignalManager.bottle_returned.connect(handle_quest_completed)
#endregion

#region METHOD - SIGNAL
func handle_quest_completed() -> void:
	remainingQuestCompletionCount -= 1
	
	if remainingQuestCompletionCount < 1:
		SignalManager.handleGameEnded()
#endregion
