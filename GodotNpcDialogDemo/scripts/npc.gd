extends CharacterBody3D

#region VARIABLE
const SPEED = 1.3
const POST_WAVE_DELAY = 10.0

const ANIM_IDLE := "Idle0"
const ANIM_WALKING := "Walking0"
const ANIM_WAVING := "Waving0"

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback:AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

@export var points_of_interest:Array[Node3D] = []

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var walking := false
var awareness_range := 3.0 
var post_wave_delay_temp := POST_WAVE_DELAY
var player
var player_noticed := false
#endregion

#region FUNCTION - NATIVE
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	enableWanderState()
	
#func _process(delta:float) -> void:
	#if walking:
		#enableWanderState()
	#elif player_noticed:
		## navigation_agent_3d.target_position = player.global_position
		## navigation_agent_3d.target_position = point_of_interest.global_position
		#post_wave_delay_temp -= delta
		#
		## if post_wave_delay_temp == POST_WAVE_DELAY:
		#enableSocializeState()
	#else:
		#enableIdleState()

func _physics_process(delta:float) -> void:
	var current_location = global_transform.origin
	var next_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	
	## #######################################################################
	var distance = global_position.distance_to(player.global_position)
	if distance <= awareness_range:
		if not player_noticed:
			enableSocializeState()
	
	if walking:
		look_at(next_location)
		playback.travel(ANIM_WALKING)
	elif player_noticed:
		look_at(player.global_position)
		playback.travel(ANIM_IDLE)
	## #######################################################################
	
	move_and_slide()
#endregion
	
#region FUNCTION - CUSTOM
func set_target(target_position:Vector3) -> void:
	navigation_agent_3d.target_position = target_position

func get_random_point_of_interest()->Vector3:
	return points_of_interest[randi() % points_of_interest.size()].global_position

func enableWanderState()->void:
	walking = true
	player_noticed = false
	
	set_target(get_random_point_of_interest())
	
func enableSocializeState()->void:
	walking = false
	player_noticed = true
	
	set_target(global_position)
#endregion

#region FUNCTION - SIGNAL
func _on_navigation_agent_3d_target_reached() -> void:
	print("target reached!")
#endregion
