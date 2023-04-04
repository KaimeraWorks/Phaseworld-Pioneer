extends TileMap

@export var map_radius = 3

var player_occupied_cell = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_moved(player_position):
	var player_new_cell = local_to_map(player_position)
	if player_new_cell != player_occupied_cell:
		player_occupied_cell = player_new_cell
		var mapped_cells = []
		for q in range(-map_radius, map_radius + 1):
			for r in range(-map_radius - q if q < 0 else -map_radius, map_radius - q + 1 if q > 0 else map_radius + 1):
				mapped_cells.append(Vector2i(q + player_occupied_cell.x, r + player_occupied_cell.y))
		for cell in get_used_cells(0):
			if cell not in mapped_cells:
				erase_cell(0, cell)
			else:
				mapped_cells.erase(cell)
		for cell in mapped_cells:
			set_cell(0, cell, 1, Vector2i(0, randi_range(0, 1)))
