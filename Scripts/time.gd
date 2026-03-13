extends Label

var time := 0.0
func _ready() -> void:
	time = 0.0

func _process(delta: float) -> void:
	if GameManager.timer:
		time += delta
	
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	
	text = "Time Survived: %02d:%02d" % [minutes, seconds]
