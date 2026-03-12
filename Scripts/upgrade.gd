extends NinePatchRect

@onready var ds: NinePatchRect = $CanvasLayer/ds
func _ready() -> void:
	ds.visible = false
func _on_start_mouse_entered() -> void:
	ds.visible = true


func _on_start_mouse_exited() -> void:
	ds.visible = false
