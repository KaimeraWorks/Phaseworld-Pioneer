extends TileMap

const MAX_PLANTS_PER_CELL = 3

@export var map_radius = 3

var player_occupied_cell = null
var plant_database = {}

var plant_scene = preload("res://plant.tscn")

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
				if plant_database.has(cell):
					while not plant_database[cell].is_empty():
						plant_database[cell].pop_back().queue_free()
					plant_database.erase(cell)
			else:
				mapped_cells.erase(cell)
		for cell in mapped_cells:
			var tile_used = randi_range(0, 1)
			set_cell(0, cell, 1, Vector2i(0, tile_used))
			var plants_in_cell = randi_range(0, MAX_PLANTS_PER_CELL) if tile_used == 1 else 0
			for plant in plants_in_cell:
				var new_plant = plant_scene.instantiate()
				var cell_position = map_to_local(cell)
				new_plant.position = Vector2(cell_position.x + randf_range(-200, 200), cell_position.y + randf_range(-75, 75))
				if plant_database.has(cell):
					plant_database[cell].append(new_plant)
				else:
					plant_database[cell] = [new_plant]
				add_child(new_plant)
