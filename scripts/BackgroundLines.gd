extends Line2D


func _ready():
	var grid = get_parent().get_parent().grid
	
	add_point(grid[0][0])
	add_point(grid[0][1])
	add_point(grid[0][2])
	add_point(grid[1][2])
	add_point(grid[2][2])
	add_point(grid[2][1])
	add_point(grid[2][0])
	add_point(grid[1][0])
	
func _draw():
	var grid = get_parent().get_parent().grid
	for row in grid:
		for point in row:
			draw_circle(point, 10, default_color)
