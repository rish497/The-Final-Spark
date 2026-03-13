extends ColorRect

@onready var shocks_gaiined_this_match: Label = $VBoxContainer/ShocksGained/shocksGaiinedThisMatch
@onready var shocks_gaiined_best_match: Label = $VBoxContainer/ShocksGained/shocksGaiinedBestMatch
@onready var tstm: Label = $VBoxContainer/TimeSurvived/TSTM
@onready var tsbm: Label = $VBoxContainer/TimeSurvived/TSBM
@onready var wth: Label = $VBoxContainer/Waves/WTH
@onready var wbt: Label = $VBoxContainer/Waves/WBT

func _process(delta: float) -> void:
	shocks_gaiined_best_match.text = str(GameManager.st)
	shocks_gaiined_this_match.text= str(GameManager.sm)
	tsbm.text = str(GameManager.besttime)
	tstm.text = str(GameManager.tm)
	wth.text = str(GameManager.wave)
	wbt.text = str(GameManager.wb)
