extends Node2D

var grid = [
			[Vector2(100,100), Vector2(300,80), Vector2(500,100)],
			[Vector2(80,300), Vector2(300,300), Vector2(520,300)],
			[Vector2(100,500), Vector2(300,520), Vector2(500,500)],
		]

func _ready():
	Engine.max_fps = 60
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	get_viewport().transparent_bg = true

