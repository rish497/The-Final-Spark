extends Node2D

@onready var tilemap: TileMapLayer = $BasicMap
@export var human_scene: PackedScene
@export var spawn_tile_atlas: Vector2i = Vector2i(3, 2)
var spawn_count: int
@onready var label: Label = $CanvasLayer/Label
@onready var nws: Label = $"CanvasLayer/next wave in"
@onready var death_screen: ColorRect = $"CanvasLayer/Death Screen"
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect2
var death_played = false
var counting_started = false
var game_started = false
func _ready():
	GameManager.tto = true
	GameManager.money = 0
	GameManager.death = false
	GameManager.pause = false
	GameManager.tm = 0
	death_screen.visible = false
	GameManager.wave = 0
	color_rect.visible = true
	await get_tree().create_timer(1.5).timeout
	label.text ="3"
	await get_tree().create_timer(1).timeout
	label.text ="2"
	await get_tree().create_timer(1).timeout
	label.text ="1"
	await get_tree().create_timer(1).timeout
	GameManager.tto = false
	label.visible = false
	GameManager.timer = true
	color_rect.visible = false
	spawn_count = 1
	GameManager.wave = 1

	spawn_asset()
	counting_started = true
	game_started = true
	await start_waves()

func wait_if_paused():
	while GameManager.pause:
		await get_tree().process_frame


func start_waves():
	while !GameManager.death:
		
		await wait_if_paused()
		await get_tree().create_timer(16).timeout
		
		await wait_if_paused()
		GameManager.animate_panel_in(nws)

		nws.text = "NEXT WAVE IN 3..."
		await get_tree().create_timer(1).timeout

		await wait_if_paused()
		nws.text = "NEXT WAVE IN 2..."
		await get_tree().create_timer(1).timeout

		await wait_if_paused()
		nws.text = "NEXT WAVE IN 1..."
		await get_tree().create_timer(1).timeout

		await wait_if_paused()
		GameManager.animate_panel_out(nws)

		spawn_count += GameManager.spawnrate
		GameManager.wave += 1

		for i in range(spawn_count):
			spawn_asset()
@onready var navigation_region_2d: NavigationRegion2D = $NavigationRegion2D
func get_random_ground_position() -> Vector2:
	var nav_map = navigation_region_2d.get_navigation_map()
	return NavigationServer2D.map_get_random_point(nav_map, 1, true)

func _process(delta: float) -> void:
	if counting_started:
		GameManager.humans = get_tree().get_nodes_in_group("human").size()

	if counting_started and GameManager.humans == 0 and !death_played:
		death_played = true
		await death()
		
@onready var bbb: ColorRect = $CanvasLayer/BBB
@onready var bbb_2: ColorRect = $CanvasLayer/BBB2
@onready var a: Label = $CanvasLayer/a

func death():
	
	GameManager.wm = GameManager.wave
	GameManager.sm = GameManager.money
	GameManager.shocktotal += GameManager.money
	if GameManager.tm > GameManager.besttime:
		GameManager.besttime = GameManager.tm

	if GameManager.wave > GameManager.wb:
		GameManager.wb = GameManager.wave

	if GameManager.money > GameManager.sb:
		GameManager.sb = GameManager.money

	GameManager.timer = false
	await GameManager.move_to(bbb, Vector2(564,247))
	await GameManager.move_to(bbb_2, Vector2(-23,247))
	await get_tree().create_timer(0.5).timeout
	await GameManager.fade_in(a)
	await get_tree().create_timer(1).timeout
	await GameManager.fade_in(death_screen)
	
func spawn_asset():
	var pos = get_random_ground_position()
	if pos == Vector2.ZERO:
		print("No valid ground found")
		return

	var item = human_scene.instantiate()
	item.global_position = pos
	add_child(item)

	print("Asset spawned at:", pos)
	
