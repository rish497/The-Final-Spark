extends Control

@export var electricity_scene: PackedScene
@onready var area_2d: Area2D = $Area2D
@onready var title: NinePatchRect = $CanvasLayer/title
@onready var start: NinePatchRect = $CanvasLayer/start
@onready var shop: NinePatchRect = $CanvasLayer/shop
@onready var exit: NinePatchRect = $CanvasLayer/exit
@onready var pfp: NinePatchRect = $CanvasLayer/pfp


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

@onready var pfp_2: NinePatchRect = $CanvasLayer/pfp2

func _on_pfp_pressed() -> void:
	if pfp_2.visible == false:
		title.visible = false
		start.visible = false
		shop.visible = false
		exit.visible = false
		GameManager.animate_panel_in(pfp_2)
	else:
		title.visible = true
		start.visible = true
		shop.visible = true
		exit.visible = true
		GameManager.animate_panel_out(pfp_2)


func _on_start_pressed() -> void:
	Transition.change_scene(self,"MainMap")

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_start_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_start_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_exit_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_exit_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_shop_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_shop_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_pfp_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_pfp_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)


func _on_shop_pressed() -> void:
	Transition.change_scene(self,"shop")
