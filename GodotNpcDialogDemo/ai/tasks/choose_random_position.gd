extends BTAction

@export var range_min_in_dir:float = 40.0
@export var range_max_in_dir:float = 100.0

@export var position_var:StringName = &"pos"
@export var dir_var:StringName = &"dir"



var points_of_interest
var last_point_of_interest_index:int



func _ready() -> void:
	points_of_interest = agent.get_tree().get_nodes_in_group("points_of_interest")		#scene_root

func _tick(_delta:float) -> Status:
	var pos:Vector3
	var dir = random_dir()
	#pos = random_pos(dir)
	pos = get_random_point_of_interest()
	blackboard.set_var(position_var, pos)
	
	
	var navigation_agent: NavigationAgent3D = agent.get_node("NavigationAgent3D")
	
	navigation_agent.target_position = pos
	
	
	
	
	print("blackboard pos: ", pos)
	
	return SUCCESS

func random_dir() -> int:
	var dir = randi_range(-2, 1)
	blackboard.set_var(dir_var, dir)
	return dir

#func random_pos(dir:int) -> Vector3:
	#print("points of interest count: ", len(points_of_interest))
	#
	##var vector:Vector2
	##var distance = randi_range(range_min_in_dir, range_max_in_dir) * dir
	##var final_position = distance * agent.global_position.x
	##vector.x = final_position
	##return vector
	#return points_of_interest
	
func get_random_point_of_interest()->Vector3:
	var points_of_interest = scene_root.get_tree().get_nodes_in_group("points_of_interest")
	var points_of_interest_count = points_of_interest.size()
	var random_index = 0
	
	if points_of_interest_count > 1:
		random_index = last_point_of_interest_index
		while random_index == last_point_of_interest_index:
			random_index = randi() % points_of_interest_count

	last_point_of_interest_index = random_index

	return points_of_interest[random_index].global_position
