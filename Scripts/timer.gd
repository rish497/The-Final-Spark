extends Label
@onready var timer: Label = $"."

var time := 0.0
func _ready() -> void:
	time = 0.0
	
func _process(delta: float) -> void:
	if GameManager.timer:
		time += delta
		GameManager.tm = time
	
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	
	timer.text = "Time Survived: %02d:%02d" % [minutes, seconds]
