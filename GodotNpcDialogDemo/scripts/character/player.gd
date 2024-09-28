extends CharacterBody3D

#region VARIABLE
@onready var actionable_finder: Area3D = $Direction/ActionableFinder

@export var walking_sound:AudioStreamPlayer

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.001

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion := Vector2.ZERO
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	set_mouse_input_mode(true)
	
	SignalManager.game_ended.connect(handle_game_ended)

func _physics_process(delta: float) -> void:
	handle_camera_rotation()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	handle_walk_sounds()

	move_and_slide()

func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * MOUSE_SENSITIVITY
	if event.is_action_pressed("ui_cancel"):
		set_mouse_input_mode(false)

# ty - what's diff b/n input and unhandled input?
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
#endregion

#region METHOD - UTIL
func set_mouse_input_mode(captured:bool) -> void:
	if captured:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#endregion

#region METHOD - HANDLER
func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	mouse_motion = Vector2.ZERO
	
func handle_walk_sounds() -> void:
	if velocity.length() != 0:
		if not walking_sound.playing:
			walking_sound.pitch_scale = randf_range(.8, 1.2)
			walking_sound.play()
#endregion

#region METHOD - SIGNAL
func handle_game_ended() -> void:
	set_mouse_input_mode(false)
#endregion
