extends BTAction

@export var target_pos_var := &"pos"
@export var dir_var := &"dir"

@export var speed_var = 40
@export var tolerance = 10

func _tick(_delta:float) -> Status:
	var target_pos: Vector3 = blackboard.get_var(target_pos_var, Vector3.ZERO)
	var dir = blackboard.get_var(dir_var)
	
	var navigation_agent: NavigationAgent3D = agent.get_node("NavigationAgent3D")
	if navigation_agent.is_navigation_finished():
		return SUCCESS
	else:
		return RUNNING
	#if abs(agent.global_position.x - target_pos.x) < tolerance:
		##agent.move(dir, 0)
		#return SUCCESS
	#else:
		##agent.move(dir, speed_var)
		#return RUNNING
		
	return RUNNING
