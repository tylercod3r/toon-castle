extends Node

#region VARIABLE
@onready var bottle_v_box: VBoxContainer = $PanelContainer/HBoxContainer/BottleVBox
@onready var bottle_image: TextureRect = $PanelContainer/HBoxContainer/BottleVBox/BottleImage
@onready var bottle_image_fill: TextureRect = $PanelContainer/HBoxContainer/BottleVBox/BottleImageFill

@onready var cheese_v_box: VBoxContainer = $PanelContainer/HBoxContainer/CheeseVBox
@onready var cheese_image: TextureRect = $PanelContainer/HBoxContainer/CheeseVBox/CheeseImage
@onready var cheese_image_fill: TextureRect = $PanelContainer/HBoxContainer/CheeseVBox/CheeseImageFill

@onready var key_v_box: VBoxContainer = $PanelContainer/HBoxContainer/KeyVBox
@onready var key_image: TextureRect = $PanelContainer/HBoxContainer/KeyVBox/KeyImage
@onready var key_image_fill: TextureRect = $PanelContainer/HBoxContainer/KeyVBox/KeyImageFill

const BOTTLE_INDEX:int = 0
const CHEESE_INDEX:int = 1
const KEY_INDEX:int = 2
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	reset()
	
	SignalManager.guard_keys_found.connect(handle_keys_found)
	SignalManager.cheese_found.connect(handle_cheese_found)
	SignalManager.bottle_found.connect(handle_bottle_found)
	
	SignalManager.guard_keys_returned.connect(handle_keys_returned)
	SignalManager.cheese_returned.connect(handle_cheese_returned)
	SignalManager.bottle_returned.connect(handle_bottle_returned)
#endregion

#region METHOD - UTIL
func reset() -> void:
	fill_icon(0, false)
	fill_icon(1, false)
	fill_icon(2, false)

func fill_icon(index:int, fill:bool) -> void:
	match(index):
		0:
			bottle_image.visible = !fill
			bottle_image_fill.visible = fill
		1:
			cheese_image.visible = !fill
			cheese_image_fill.visible = fill
		2:
			key_image.visible = !fill
			key_image_fill.visible = fill
#endregion

#region METHOD - HANDLER
func handle_bottle_found() -> void:
	fill_icon(BOTTLE_INDEX, true)
	
func handle_cheese_found() -> void:
	fill_icon(CHEESE_INDEX, true)

func handle_keys_found() -> void:
	fill_icon(KEY_INDEX, true)

func handle_bottle_returned() -> void:
	bottle_v_box.visible = false
	
func handle_cheese_returned() -> void:
	cheese_v_box.visible = false

func handle_keys_returned() -> void:
	key_v_box.visible = false
#endregion
