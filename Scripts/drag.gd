extends Camera2D

var dragging := false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

	if event is InputEventMouseMotion and dragging:
		position -= event.relative * zoom
