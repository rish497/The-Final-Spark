extends CanvasLayer
@onready var start: Button = $start/start

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		start.emit_signal("pressed")
