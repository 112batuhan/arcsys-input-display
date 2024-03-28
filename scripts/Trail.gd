extends Line2D

@export var deletion_time:int = 500

var queue:Array
var last_pos = Vector2(0,0)

func _physics_process(delta):
	var pos = get_parent().position
	var current_time = Time.get_ticks_msec()

	
	if last_pos != pos:
		if queue.is_empty():
			queue.push_front({"position": last_pos, "time": current_time + deletion_time})
		queue.push_front({"position": pos, "time": current_time + deletion_time})
	last_pos = pos
	
	for i in range(queue.size() - 1, -1, -1):
		if queue[i]["time"] < current_time:
			queue.pop_back()
		else:
			break
	
	clear_points()
	
	for i in range(queue.size() - 1, -1, -1):
		add_point(queue[i]["position"])
	
	

