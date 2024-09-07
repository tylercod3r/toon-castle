extends CharacterBody3D
class_name Npc

#region VARIABLE
# constants
const SPEED = 1.3
const INVALID_INDEX = -1

# constants - animation
const ANIM_IDLE := "Idle0"
const ANIM_WALKING := "Walking0"
const ANIM_WAVING := "Waving0"
const ANIM_DANCING := "Dancing0"

# enums
enum NPC_STATE {
	IDLE,
	WANDER, 
	PLAYER_SPOTTED,
	WANDER_RESUME, 
	VISITING_POINT_OF_INTEREST,
	CELEBRATE
	}

# references - display tree
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var animation_player: AnimationPlayer = $Mesh/AnimationPlayer

# references - timers
@onready var wander_resume_delay_timer: Timer = $WanderResumeDelayTimer
@onready var point_of_interest_duration_timer: Timer = $PointOfInterestDurationTimer

# exports
@export var points_of_interest:Array[Node3D] = []
@export var player_awareness_range := 3.0 

# variables
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var player
var wander_target :Vector3
var last_point_of_interest_index:int = INVALID_INDEX

# variables - state
var hsm:LimboHSM
var idle_state:LimboState
var wander_state:LimboState
var player_spotted_state:LimboState
var wander_resumed_state:LimboState
var visiting_point_of_interest_state:LimboState
var celebrate_state:LimboState
#endregion

#region METHOD - NATIVE
func _ready() -> void:
	init()
	
func init() -> void:
	# reference
	player = get_tree().get_first_node_in_group("player")
	
	# state
	_init_state_machine()
	set_current_state(NPC_STATE.IDLE)
#endregion

#region METHOD - GET / SET
func set_target(target_position:Vector3) -> void:
	navigation_agent_3d.target_position = target_position

func get_random_point_of_interest()->Vector3:
	var points_of_interest_count = points_of_interest.size()
	var random_index = 0
	
	if points_of_interest_count > 1:
		random_index = last_point_of_interest_index
		while random_index == last_point_of_interest_index:
			random_index = randi() % points_of_interest_count

	last_point_of_interest_index = random_index

	return points_of_interest[random_index].global_position
	
func set_random_point_of_interest() -> void:
	# target
	wander_target = get_random_point_of_interest()
	set_target(wander_target)
	
func is_player_nearby() -> bool:
	var distance = global_position.distance_to(player.global_position)
	return distance <= player_awareness_range
#endregion

#region METHOD - STATE
func set_current_state(newState:NPC_STATE) -> void:
	#if newState == current_state:
		#return
	
	print("STATE: ", NPC_STATE.keys()[newState])
	
	match newState:
		NPC_STATE.WANDER:
			hsm.dispatch(&"wander_started")
		NPC_STATE.WANDER_RESUME:
			hsm.dispatch(&"wander_resumed")
		NPC_STATE.PLAYER_SPOTTED:
			hsm.dispatch(&"player_spotted")
		NPC_STATE.VISITING_POINT_OF_INTEREST:
			hsm.dispatch(&"visiting_point_of_interest_started")
		NPC_STATE.CELEBRATE:
			hsm.dispatch(&"celebrate_started")

func _init_state_machine() -> void:
	hsm = LimboHSM.new()
	add_child(hsm)
	
	idle_state = LimboState.new().named(str(NPC_STATE.IDLE)).call_on_enter(idle_state_ready).call_on_update(idle_state_physics_process)
	wander_state = LimboState.new().named(str(NPC_STATE.WANDER)).call_on_enter(_wander_state_ready).call_on_update(_wander_state_physics_process)
	player_spotted_state = LimboState.new().named(str(NPC_STATE.PLAYER_SPOTTED)).call_on_enter(_player_spotted_state_ready).call_on_update(_player_spotted_state_physics_process)
	wander_resumed_state = LimboState.new().named(str(NPC_STATE.WANDER_RESUME)).call_on_enter(_wander_resumed_state_ready).call_on_update(_wander_resumed_state_physics_process)
	visiting_point_of_interest_state = LimboState.new().named(str(NPC_STATE.VISITING_POINT_OF_INTEREST)).call_on_enter(_visiting_point_of_interest_state_ready).call_on_update(_visiting_point_of_interest_state_physics_process)
	celebrate_state = LimboState.new().named(str(NPC_STATE.CELEBRATE)).call_on_enter(_celebrate_state_ready).call_on_update(_celebrate_state_physics_process)
	
	hsm.add_child(idle_state)
	hsm.add_child(wander_state)
	hsm.add_child(player_spotted_state)
	hsm.add_child(wander_resumed_state)
	hsm.add_child(visiting_point_of_interest_state)
	hsm.add_child(celebrate_state)
	
	hsm.add_transition(idle_state, wander_state, &"wander_started")
	hsm.add_transition(player_spotted_state, wander_resumed_state, &"wander_resumed")
	hsm.add_transition(celebrate_state, wander_resumed_state, &"wander_resumed")
	
	hsm.add_transition(wander_state, idle_state, &"wander_ended")
	hsm.add_transition(wander_state, player_spotted_state, &"player_spotted")
	hsm.add_transition(wander_resumed_state, wander_state, &"wander_started")

	hsm.add_transition(wander_state, visiting_point_of_interest_state, &"visiting_point_of_interest_started")
	hsm.add_transition(visiting_point_of_interest_state, wander_state, &"wander_started")
	hsm.add_transition(visiting_point_of_interest_state, player_spotted_state, &"player_spotted")

	hsm.add_transition(hsm.ANYSTATE, celebrate_state, &"celebrate_started")

	hsm.add_transition(hsm.ANYSTATE, idle_state, &"state_ended")
	
	hsm.initial_state = idle_state
	
	hsm.initialize(self)
	hsm.set_active(true)

func idle_state_ready() -> void:
	# target
	set_random_point_of_interest()
	
	# timer
	wander_resume_delay_timer.stop()
	wander_resume_delay_timer.start()

func idle_state_physics_process(_delta:float) -> void:
	# animate
	animation_player.play(ANIM_IDLE)
	
func _wander_state_ready() -> void:
	# timer
	point_of_interest_duration_timer.stop()

func _wander_state_physics_process(_delta:float) -> void:
	# velocity
	var current_location = global_transform.origin
	var next_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = velocity.move_toward(new_velocity, 0.25)
	
	# rotate
	look_at_fixed(next_location)
	
	# animate
	animation_player.play(ANIM_WALKING)
	move_and_slide()
	
	# state
	#if is_player_nearby():
		#set_current_state(NPC_STATE.PLAYER_SPOTTED)

func _player_spotted_state_ready() -> void:
	# timer
	wander_resume_delay_timer.start()

func _player_spotted_state_physics_process(_delta:float) -> void:
	# rotate
	look_at_fixed(player.position)

	# animate
	animation_player.play(ANIM_WAVING)

func _wander_resumed_state_ready() -> void:
	# target
	wander_target = points_of_interest[last_point_of_interest_index].global_position
	set_target(wander_target)
	
	# state
	set_current_state(NPC_STATE.WANDER)

func _wander_resumed_state_physics_process(_delta:float) -> void:
	pass

func _visiting_point_of_interest_state_ready() -> void:
	# timer
	point_of_interest_duration_timer.start()

func _visiting_point_of_interest_state_physics_process(delta:float) -> void:
	# rotate
	look_at_fixed(navigation_agent_3d.get_next_path_position())
	
	# animate
	animation_player.play(ANIM_IDLE)
	
	#if is_player_nearby():
		## timer
		#point_of_interest_duration_timer.stop()
		#
		## state
		#set_current_state(NPC_STATE.PLAYER_SPOTTED)

func _celebrate_state_ready() -> void:
	# target
	set_target(global_position)
	
	# timer
	wander_resume_delay_timer.start()

func _celebrate_state_physics_process(_delta:float) -> void:
	# animate
	animation_player.play(ANIM_DANCING)
#endregion

#region METHOD - SIGNAL
func _on_navigation_agent_3d_target_reached() -> void:
	# state
	if hsm.get_active_state() == celebrate_state:
		pass
	else:
		set_current_state(NPC_STATE.VISITING_POINT_OF_INTEREST)
	
func _on_wander_resume_delay_timer_timeout() -> void:
	# state
	var current_state = hsm.get_active_state()
	#if is_player_nearby():
		## timer
		#wander_resume_delay_timer.start()
		#
		## state
		#set_current_state(NPC_STATE.PLAYER_SPOTTED)
	if current_state == player_spotted_state || current_state == celebrate_state:
		# state
		set_current_state(NPC_STATE.WANDER_RESUME)
	else:
		# state
		set_current_state(NPC_STATE.WANDER)

func _on_point_of_interest_duration_timer_timeout() -> void:
	# target
	set_random_point_of_interest()
	
	# state
	set_current_state(NPC_STATE.WANDER)
#endregion

#region METHOD - LOOK AT
# https://www.reddit.com/r/godot/comments/17oy7t1/3d_look_at_the_player_without_using_the_look_at/?rdt=49445
func look_at_fixed(target:Vector3) -> void:
	target.y = position.y
	look_at(target)
#endregion
