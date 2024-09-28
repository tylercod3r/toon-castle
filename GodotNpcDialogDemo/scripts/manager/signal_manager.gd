extends Node

#region VARIABLE
signal player_converse_to_npc

signal guard_spoken_to
signal guard_end_spoken_to
signal guard_keys_found
signal guard_keys_returned

signal mousey_spoken_to
signal mousey_end_spoken_to
signal cheese_found
signal cheese_returned

signal doozy_spoken_to
signal doozy_end_spoken_to
signal bottle_found
signal bottle_returned

signal celebration_ended

signal game_ended
#endregion

#region METHOD - GAME
func handleGameEnded() -> void:
	game_ended.emit()
#endregion

#region METHOD - GUARD
func handleGuardSpokenTo() -> void:
	guard_spoken_to.emit()
	
func handleGuardEndSpokenTo() -> void:
	guard_end_spoken_to.emit()
	
func handleGuardkeysFound() -> void:
	guard_keys_found.emit()
	
func handleGuardkeysReturned() -> void:
	guard_keys_returned.emit()

func handleCelebrationEnded() -> void:
	celebration_ended.emit()
#endregion

#region METHOD - MOUSEY
func handleMouseySpokenTo() -> void:
	mousey_spoken_to.emit()
	
func handleMouseyEndSpokenTo() -> void:
	mousey_end_spoken_to.emit()
	
func handleCheeseFound() -> void:
	cheese_found.emit()
	
func handleCheeseReturned() -> void:
	cheese_returned.emit()
#endregion

#region METHOD - DOOZY
func handleDoozySpokenTo() -> void:
	doozy_spoken_to.emit()
	
func handleDoozyEndSpokenTo() -> void:
	doozy_end_spoken_to.emit()
	
func handleBottleFound() -> void:
	bottle_found.emit()
	
func handleBottleReturned() -> void:
	bottle_returned.emit()
#endregion
