extends Label

func _process(delta: float) -> void:
	self.text = "Wave Number: " + str(GameManager.wave)
