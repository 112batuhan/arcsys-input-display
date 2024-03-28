extends Sprite2D

@export var follow_speed = 50

var previous_pos = Vector2(300,300)
var targets: Array

func get_stick_target_pos():
	var pos = Vector2(300,300)
	if Input.is_action_pressed("up"):
		pos.y -= 200
	if Input.is_action_pressed("down"):
		pos.y += 200
	if Input.is_action_pressed("left"):
		pos.x -= 200
	if Input.is_action_pressed("right"):
		pos.x += 200
	return pos
		
	
func _physics_process(delta):
	var target_pos = get_stick_target_pos()
	
	if target_pos != previous_pos:
		targets.push_front(target_pos)
	previous_pos = target_pos

	if !targets.is_empty():
		position = position.lerp(targets.back(), delta * follow_speed)
		if position.distance_to(targets.back()) < 1:
			position = targets.pop_back()
			

	
