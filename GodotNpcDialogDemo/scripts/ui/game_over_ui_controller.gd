extends Node

func _on_replay_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
