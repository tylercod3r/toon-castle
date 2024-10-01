extends Node

#region VARIABLE
@onready var canvas_layer_1: CanvasLayer = $CanvasLayer1
@onready var canvas_layer_2: CanvasLayer = $CanvasLayer2
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	SignalManager.game_ended.connect(show_game_over)
	
	show(false)
#endregion

#region METHOD - UTIL
func show_game_over() -> void:
	show(true)

func show(visible:bool) -> void:
	canvas_layer_1.visible = visible
	canvas_layer_2.visible = visible
#endregion

#region METHOD - SIGNAL
func _on_replay_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
#endregion
