extends Node

signal guard_keys_found
signal guard_keys_returned

func handleGuardkeysFound() -> void:
	guard_keys_found.emit()
	
func handleGuardkeysReturned() -> void:
	guard_keys_returned.emit()
