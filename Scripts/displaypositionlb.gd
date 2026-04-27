extends Label

func _process(delta: float) -> void:
	self.text = str(GameManager.player_rank)
