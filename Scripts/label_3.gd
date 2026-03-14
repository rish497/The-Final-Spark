extends Label

func _process(delta: float) -> void:
	self.text = str(GameManager.humans)
	if GameManager.humans == 0:
		GameManager.death = true
