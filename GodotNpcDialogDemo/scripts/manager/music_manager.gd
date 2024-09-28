extends Node

#region VARIABLE
@export var main_music:AudioStreamPlayer;
@export var celebration_music:AudioStreamPlayer;
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	SignalManager.guard_keys_returned.connect(celebrate)
	SignalManager.bottle_returned.connect(celebrate)
	SignalManager.cheese_returned.connect(celebrate)
	
	SignalManager.celebration_ended.connect(end_celebration)
	
	if main_music:
		main_music.play()
#endregion

#region METHOD - SIGNAL
func celebrate() -> void:
	if main_music:
		main_music.stop()
		celebration_music.play()

func end_celebration() -> void:
	if main_music:
		celebration_music.stop()
		main_music.play()
#endregion
