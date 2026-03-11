extends NinePatchRect

@onready var ds: NinePatchRect = $start2

func _on_start_mouse_entered() -> void:
	ds.visible = true


func _on_start_mouse_exited() -> void:
	ds.visible = false
