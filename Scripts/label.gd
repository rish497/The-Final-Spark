extends Label

func _ready():
	increase_money()

func _process(delta: float) -> void:
	text = str(GameManager.money)

func increase_money():
	while true:
		if GameManager.timer:
			GameManager.money += 1
		await get_tree().create_timer(.5).timeout
		
