extends CharacterBody3D

#region VARIABLE
const SPEED = 1.3

const ANIM_IDLE := "Idle0"
const ANIM_WALKING := "Walking0"
const ANIM_WAVING := "Waving0"

enum STATE {WANDER, PLAYER_SPOTTED, WANDER_RESUME, VISITING_POINT_OF_INTEREST}

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback:AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var wander_resume_delay_timer: Timer = $WanderResumeDelayTimer
@onready var point_of_interest_duration_timer: Timer = $PointOfInterestDurationTimer

@export var points_of_interest:Array[Node3D] = []

var current_state:STATE
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var awareness_range := 3.0 
var player
var wander_target :Vector3
#endregion

func set_current_state(newState:STATE) -> void:
	#if newState == current_state:
		#return
	
	if newState == STATE.WANDER:
		wander_target = get_random_point_of_interest()
		set_target(wander_target)
	elif newState == STATE.WANDER_RESUME:
		# #### REPLACE BELOW WITH LAST ACTION INDEX!! 
		wander_target = get_random_point_of_interest()
		# ##########################################
		set_target(wander_target)
	elif newState == STATE.PLAYER_SPOTTED:
		set_target(global_position)
		wander_resume_delay_timer.start()
	elif newState == STATE.VISITING_POINT_OF_INTEREST:
		point_of_interest_duration_timer.start()
	
	current_state = newState

#region FUNCTION - NATIVE
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	set_current_state(STATE.WANDER)

func _physics_process(delta:float) -> void:
	# set velocity
	var current_location = global_transform.origin
	var next_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = velocity.move_toward(new_velocity, 0.25)
	
	# set state based on player distance
	var distance = global_position.distance_to(player.global_position)
	if distance <= awareness_range:
		if current_state != STATE.PLAYER_SPOTTED:
			set_current_state(STATE.PLAYER_SPOTTED)
	else:
		if current_state == STATE.PLAYER_SPOTTED:
			set_current_state(STATE.WANDER_RESUME)
	
	# handle state
	if current_state == STATE.WANDER:
		look_at(next_location)
		playback.travel(ANIM_WALKING)
	elif current_state == STATE.WANDER_RESUME:
		look_at(next_location)
		playback.travel(ANIM_WALKING)
	elif current_state == STATE.PLAYER_SPOTTED:
		look_at(player.global_position)
		playback.travel(ANIM_IDLE)
	
	move_and_slide()
#endregion
	
#region FUNCTION - CUSTOM
func set_target(target_position:Vector3) -> void:
	navigation_agent_3d.target_position = target_position

func get_random_point_of_interest()->Vector3:
	return points_of_interest[randi() % points_of_interest.size()].global_position
#endregion

#region FUNCTION - SIGNAL
func _on_navigation_agent_3d_target_reached() -> void:
	set_current_state(STATE.VISITING_POINT_OF_INTEREST)
	
func _on_wander_resume_delay_timer_timeout() -> void:
	set_current_state(STATE.WANDER_RESUME)
	
func _on_point_of_interest_duration_timer_timeout() -> void:
	set_current_state(STATE.WANDER)
#endregion
