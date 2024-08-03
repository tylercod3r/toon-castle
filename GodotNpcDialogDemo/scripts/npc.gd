extends CharacterBody3D

#region VARIABLES
const SPEED = 1.3
const POST_WAVE_DELAY = 10.0

const ANIM_IDLE := "Idle0"
const ANIM_WALKING := "Walking0"
const ANIM_WAVING := "Waving0"

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D




@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback:AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@export var point_of_interest:Node3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var walking := false
var awareness_range := 2.0 
var post_wave_delay_temp := POST_WAVE_DELAY
var player
var player_noticed := false
#endregion

#region FUNCTIONS - NATIVE
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	navigation_agent_3d.target_position = point_of_interest.global_position
	# enableWalkState()
	
#func _process(delta:float) -> void:
	#if walking:
		#enableWalkState()
	#elif player_noticed:
		## navigation_agent_3d.target_position = player.global_position
		## navigation_agent_3d.target_position = point_of_interest.global_position
		#post_wave_delay_temp -= delta
		#
		## if post_wave_delay_temp == POST_WAVE_DELAY:
		#enableWaveState()
	#else:
		#enableIdleState()

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
	#
	## #######################################################################
	#var distance = global_position.distance_to(player.global_position)
	#if distance <= awareness_range:
		#player_noticed = true
		## look_at(player.global_position)
	## #######################################################################
#
	#var next_position = navigation_agent_3d.target_position
	## look_at(next_position)
#
	#var direction = global_position.direction_to(next_position) 
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
	
func _physics_process(delta:float) -> void:
	var current_location = global_transform.origin
	var next_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	
	## #######################################################################
	#var distance = global_position.distance_to(player.global_position)
	#if distance <= awareness_range:
		#player_noticed = true
		## look_at(player.global_position)
	look_at(next_location)
	## #######################################################################
	
	playback.travel(ANIM_WALKING)
	
	move_and_slide()
	
func update_target_location(target_location) -> void:
	navigation_agent_3d.set_target_location(target_location)
#endregion
	
#region FUNCTIONS - CUSTOM
func enableIdleState()->void:
	walking = false
	player_noticed = false
	
	# navigation_agent_3d.target_position = player.global_position
	navigation_agent_3d.target_position = mesh_instance_3d.global_position
	playback.travel(ANIM_IDLE)

func enableWalkState()->void:
	walking = true
	player_noticed = false
	
	# navigation_agent_3d.target_position = player.global_position
	navigation_agent_3d.target_position = point_of_interest.global_position
	playback.travel(ANIM_WALKING)
	
func enableWaveState()->void:
	walking = false
	player_noticed = true
	
	# navigation_agent_3d.target_position = player.global_position
	playback.travel(ANIM_WAVING)
	
	post_wave_delay_temp = POST_WAVE_DELAY
#endregion


func _on_navigation_agent_3d_target_reached() -> void:
	print("target reached!")
