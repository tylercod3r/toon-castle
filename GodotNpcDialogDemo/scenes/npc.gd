extends CharacterBody3D

#region VARIABLES
const SPEED = 2.0
const JUMP_VELOCITY = 4.5

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback:AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@export var point_of_interest:Node3D

var player
var provoked := false
var aggro_range := 2.0 
#endregion

#region FUNCTIONS - BUILT-IN
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	playback.travel("Walking0")
	
func _process(_delta:float) -> void:
	if provoked:
		# navigation_agent_3d.target_position = player.global_position
		navigation_agent_3d.target_position = point_of_interest.global_position
		playback.travel("Walking0")
#endregion
	
#region FUNCTIONS - CUSTOM
func enableWalkState()->void:
	navigation_agent_3d.target_position = player.global_position
	playback.travel("Walking0")

func _physics_process(delta: float) -> void:
	# #######################################################################
	var distance = global_position.distance_to(player.global_position)
	if distance <= aggro_range:
		provoked = true
	# #######################################################################

	var next_position = navigation_agent_3d.target_position
	look_at(next_position)

	var direction = global_position.direction_to(next_position) 
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
#endregion
