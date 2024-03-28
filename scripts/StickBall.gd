extends Sprite2D

@export var follow_speed = 50

var previous_pos = Vector2(300,300)
var targets: Array
var grid: Array

var actions = ["punch", "kick", "slash", "heavy", "dust", "dash", "rc", "taunt"]
var button_sprites: Array
var button_fade_speed = 10

var textures = {
		"punch": preload("res://assets/striveButtons/STRIVE_P_pressed.png"),
		"kick": preload("res://assets/striveButtons/STRIVE_K_pressed.png"),
		"slash": preload("res://assets/striveButtons/STRIVE_S_pressed.png"),
		"heavy": preload("res://assets/striveButtons/STRIVE_HS_pressed.png"),
		"dust": preload("res://assets/striveButtons/STRIVE_Dust_pressed.png"),
		"dash": preload("res://assets/striveButtons/STRIVE_Dash_pressed.png"),
		"rc": preload("res://assets/striveButtons/STRIVE_RC_pressed.png"),
		"taunt": preload("res://assets/striveButtons/STRIVE_Taunt_pressed.png"),
	}


func get_target_grid():
	var grid_pos = [1,1]
	if GlobalInput.is_action_pressed("up"):
		grid_pos[0] -= 1
	if GlobalInput.is_action_pressed("down"):
		grid_pos[0] += 1
	if GlobalInput.is_action_pressed("left"):
		grid_pos[1] -= 1
	if GlobalInput.is_action_pressed("right"):
		grid_pos[1] += 1
	return grid_pos

func _ready():
	grid = get_parent().grid
	
	
func _physics_process(delta):
	var grid_indexes = get_target_grid()
	var target_pos = grid[grid_indexes[0]][grid_indexes[1]]
	
	if target_pos != previous_pos:
		targets.push_front(target_pos)
	previous_pos = target_pos
	
	for action in actions:
		if GlobalInput.is_action_just_pressed(action):
			var sprite = Sprite2D.new()
			sprite.position = target_pos
			sprite.set_texture(textures[action])
			sprite.z_index = 2
			sprite.scale = Vector2(1.5, 1.5)
			get_parent().add_child(sprite)
			button_sprites.push_front(sprite)
			
	for i in range(button_sprites.size() - 1, -1, -1):
		button_sprites[i].modulate.a -= (1.01 - button_sprites[i].modulate.a) * delta * button_fade_speed
		if button_sprites[i].modulate.a < 0:
			button_sprites[i].queue_free()
			get_parent().remove_child(button_sprites.pop_back())
	
	if !targets.is_empty():
		position = position.lerp(targets.back(), delta * follow_speed)
		if position.distance_to(targets.back()) < 1:
			position = targets.pop_back()
			

	
