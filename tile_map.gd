extends TileMap

@export var map_radius: int = 3

var player_occupied_cell = null
var humidity: FastNoiseLite = FastNoiseLite.new()
var temperature: FastNoiseLite = FastNoiseLite.new()
var aberrance: FastNoiseLite = FastNoiseLite.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	humidity.seed = randi()
	humidity.frequency = 0.05
	temperature.seed = randi()
	temperature.frequency = 0.05
	aberrance.seed = randi()
	aberrance.frequency = 0.05

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

func imagine_cell(cell):
	set_cell(0, cell, 1, get_cell_essence(cell))

func get_cell_essence(cell) -> Vector2i:
	var local_aberrance_multiplier: float = aberrance.get_noise_2dv(cell)
	var local_humidity: float = clampf(humidity.get_noise_2dv(cell) + local_aberrance_multiplier * randf_range(-1, 1), -1, 1)
	var local_temperature: float = clampf(temperature.get_noise_2dv(cell) + local_aberrance_multiplier * randf_range(-1, 1), -1, 1)
	var memory_essence: Vector2i = Vector2i(floori((local_humidity + 1) * 1.5), floori((local_temperature + 1) * 1.5))
	var neighbor_essence: Vector2i = get_neighbor_essence(cell)
	if neighbor_essence != Vector2i(-1, -1):
		var memory_strength: float = randf_range(0, 1)
		var neighbor_strength: float = 1 - memory_strength
		var cell_x: int = roundi(memory_essence.x * memory_strength + neighbor_essence.x * neighbor_strength)
		var cell_y: int = roundi(memory_essence.y * memory_strength + neighbor_essence.y * neighbor_strength)
		return Vector2i(cell_x, cell_y)
	else:
		return memory_essence

func get_neighbor_essence(cell) -> Vector2i:
	var neighbors: Array = get_surrounding_cells(cell)
	var neighbor_sum: Vector2i = Vector2i.ZERO
	var valid_neighbors: int = 0
	for neighbor in neighbors:
		var neighbor_atlas_coords: Vector2i = get_cell_atlas_coords(0, neighbor)
		if neighbor_atlas_coords != Vector2i(-1, -1):
			neighbor_sum += neighbor_atlas_coords
			valid_neighbors += 1
	if valid_neighbors > 0:
		return Vector2i(roundi(float(neighbor_sum.x) / valid_neighbors), roundi(float(neighbor_sum.y) / valid_neighbors))
	else:
		return Vector2i(-1, -1)
