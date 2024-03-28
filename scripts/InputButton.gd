extends Sprite2D

@export var action:String
@export var key_release_transparency = 0.7

var press_color:Color
var release_color: Color
var animate_speed = 10
var press_scale: Vector2
var release_scale: Vector2

func _ready():
	press_color = modulate
	modulate.a = key_release_transparency
	release_color = modulate
	
	release_scale = scale
	press_scale = Vector2(scale.x * 1.2, scale.y * 1.2)


func _physics_process(delta):
	if GlobalInput.is_action_pressed(action):
		modulate = press_color
		scale = press_scale
	elif scale.distance_to(release_scale) > 0.001:
		modulate = modulate.lerp(release_color, delta * animate_speed )
		scale = scale.lerp(release_scale, delta * animate_speed)
	
