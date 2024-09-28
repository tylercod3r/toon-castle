extends Node

const GAME = preload("res://scenes/game.tscn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAME)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
