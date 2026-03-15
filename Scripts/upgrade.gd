extends NinePatchRect

@onready var ds: NinePatchRect = get_child(1)

func _ready() -> void:
	ds.visible = false
var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")

func _on_start_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
	ds.visible = true

func _on_start_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
	ds.visible = false
