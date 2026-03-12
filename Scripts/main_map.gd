extends Node2D

@onready var tilemap: TileMapLayer = $BasicMap
@export var human_scene: PackedScene
@export var spawn_tile_atlas: Vector2i = Vector2i(3, 2)
var spawn_count: int
@onready var label: Label = $CanvasLayer/Label

func _ready():
	label.text ="3"
	await get_tree().create_timer(1).timeout
	label.text ="2"
	await get_tree().create_timer(1).timeout
	label.text ="1"
	await get_tree().create_timer(1).timeout
	label.visible = false
	
	spawn_count = 1
	GameManager.wave = 1
	start_waves()


func start_waves():
	while true:
		for i in range(spawn_count):
			spawn_asset()
		await get_tree().create_timer(20).timeout
		spawn_count += 3
		GameManager.wave += 1
	
func get_random_ground_position() -> Vector2:
	var used_cells := tilemap.get_used_cells()
	used_cells.shuffle()

	for cell in used_cells:
		if tilemap.get_cell_source_id(cell) != -1:
			return tilemap.to_global(tilemap.map_to_local(cell))

	return Vector2.ZERO


func spawn_asset():
	var pos = get_random_ground_position()
	if pos == Vector2.ZERO:
		print("No valid ground found")
		return

	var item = human_scene.instantiate()
	item.global_position = pos
	add_child(item)

	print("Asset spawned at:", pos)

func _process(delta: float) -> void:
	GameManager.humans = get_tree().get_nodes_in_group("human").size()
