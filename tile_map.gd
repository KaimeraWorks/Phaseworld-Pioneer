extends TileMap

@export var map_radius = 3

var player_occupied_cell = null
var void_memory = FastNoiseLite.new()
var void_growth = FastNoiseLite.new()
var void_enemy = FastNoiseLite.new()
var growth_database = {}

var plant = preload("res://plant.tscn") # Temporary
var enemy = preload("res://enemy.tscn") # Temporary

# Called when the node enters the scene tree for the first time.
func _ready():
	void_memory.seed = randi()
	void_memory.frequency = 0.05
	void_growth.seed = randi()
	void_growth.frequency = 0.1
	void_enemy.seed = randi()
	void_enemy.frequency = 0.05

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
				forget_cell(cell)
			else:
				mapped_cells.erase(cell)
		for cell in mapped_cells:
			imagine_cell(cell)

func forget_cell(cell):
	erase_cell(0, cell)
	if growth_database.has(cell):
		while not growth_database[cell].is_empty():
			growth_database[cell].pop_back().queue_free()
		growth_database.erase(cell)

func imagine_cell(cell):
	var cell_essence = get_cell_essence(cell)
	set_cell(0, cell, 1, Vector2i(0, cell_essence if cell_essence != -1 else randi_range(0, 1)))
	var cell_center = map_to_local(cell)
	var cell_radius = tile_set.tile_size.x / 2.0
	var cell_apothem = tile_set.tile_size.y / 2.0
	var cell_flatness = cell_radius * sqrt(3) / 2 / cell_apothem
	for x in range(cell_center.x - cell_radius, cell_center.x + cell_radius, randi_range(25, 50)):
		for y in range(cell_center.y - cell_apothem, cell_center.y + cell_apothem, randi_range(25, 50)):
			if (x - cell_center.x) ** 2 / (cell_apothem * cell_flatness) ** 2 + (y - cell_center.y) ** 2 / (cell_apothem) ** 2 <= 1:
				if void_growth.get_noise_2d(x, y) + 1 > (1.25 if cell_essence == 0 else 1):
					var new_plant = plant.instantiate()
					new_plant.position = Vector2(x, y)
					if growth_database.has(cell):
						growth_database[cell].append(new_plant)
					else:
						growth_database[cell] = [new_plant]
					add_child(new_plant)
				elif void_enemy.get_noise_2d(x, y) + 1 > (1.75 if cell_essence == 0 else 1.5):
					var new_enemy = enemy.instantiate()
					new_enemy.position = Vector2(x, y)
					add_child(new_enemy)

func get_cell_essence(cell):
	var memory_strength = randf_range(0, 1)
	var aberrance = randf_range(-0.1, 0.1)
	var neighbor_essence = get_neighbor_essence(cell)
	var pure_essence = 0
	if neighbor_essence != -1:
		pure_essence = (void_memory.get_noise_2dv(cell) + 1) * memory_strength + neighbor_essence * (1 - memory_strength)
	else:
		pure_essence = (void_memory.get_noise_2dv(cell) + 1)
	var altered_essence = pure_essence + aberrance
	if altered_essence < 0:
		altered_essence = 0
	if altered_essence > 1:
		altered_essence = 1
	return floor(altered_essence)

func get_neighbor_essence(cell):
	var total_essence = 0.0
	var neighbor_count = 0
	for neighbor in get_surrounding_cells(cell):
		var neighbor_tile = get_cell_atlas_coords(0, neighbor)
		if neighbor_tile != Vector2i(-1, -1):
			if neighbor_tile.y == 0:
				total_essence += 1
			else:
				total_essence += 2
			neighbor_count += 1
	return total_essence / neighbor_count if neighbor_count > 0 else -1.0
