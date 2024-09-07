extends Node

signal guard_keys_found
signal guard_keys_returned

signal cheese_found
signal cheese_returned

signal bottle_found
signal bottle_returned

func handleGuardkeysFound() -> void:
	guard_keys_found.emit()
	
func handleGuardkeysReturned() -> void:
	guard_keys_returned.emit()

func handleCheeseFound() -> void:
	cheese_found.emit()
	
func handleCheeseReturned() -> void:
	cheese_returned.emit()
	
func handleBottleFound() -> void:
	bottle_found.emit()
	
func handleBottleReturned() -> void:
	bottle_returned.emit()
