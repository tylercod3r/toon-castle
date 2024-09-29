extends Node3D

#region VARIABLE
const GAME_OVER_UI = preload("res://scenes/ui/game_over_ui.tscn")

var game_over_ui_instance:Node
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	SignalManager.game_ended.connect(show_game_over)
#endregion

#region METHOD - UTIL
func show_game_over() -> void:
	game_over_ui_instance = GAME_OVER_UI.instantiate()
	add_child(game_over_ui_instance)
	
	print("show game over!")
#endregion
