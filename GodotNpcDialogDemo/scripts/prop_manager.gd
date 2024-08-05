extends Node3D

@export var guard_keys:Node3D


func handle_guard_keys_found() -> void:
	guard_keys.visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.guard_keys_found.connect(handle_guard_keys_found)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
