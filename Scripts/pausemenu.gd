extends NinePatchRect
var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_button_pressed() -> void:
	Transition.change_scene(self, "MainMenu")
	GameManager.pause = false
func _on_button_2_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_2_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_button_3_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_3_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
