extends Control

@export var electricity_scene: PackedScene
@onready var area_2d: Area2D = $Area2D

var start_position := Vector2(0, 0)

func _ready():
	area_2d.area_entered.connect(_on_area_entered)
	spawn_electricity()

func spawn_electricity():
	var e = electricity_scene.instantiate()
	e.position = start_position
	add_child(e)

func _on_area_entered(area):
	if area.is_in_group("electricity"):
		spawn_electricity()
