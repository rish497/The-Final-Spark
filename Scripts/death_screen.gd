extends ColorRect

@onready var shocks_gaiined_this_match: Label = $VBoxContainer/ShocksGained/shocksGaiinedThisMatch
@onready var shocks_gaiined_best_match: Label = $VBoxContainer/ShocksGained/shocksGaiinedBestMatch
@onready var tstm: Label = $VBoxContainer/TimeSurvived/TSTM
@onready var tsbm: Label = $VBoxContainer/TimeSurvived/TSBM
@onready var wth: Label = $VBoxContainer/Waves/WTH
@onready var wbt: Label = $VBoxContainer/Waves/WBT

func _process(delta: float) -> void:
	shocks_gaiined_best_match.text = str(GameManager.sb)
	shocks_gaiined_this_match.text= str(GameManager.money)
	tsbm.text = format_time(GameManager.besttime)
	tstm.text = format_time(GameManager.tm)
	wth.text = str(GameManager.wm - 1)
	wbt.text = str(GameManager.wb - 1)

func format_time(time_seconds) -> String:
	var t = int(time_seconds)
	var minutes = t / 60
	var seconds = t % 60
	return "%02d:%02d" % [minutes, seconds]

func _on_button_pressed() -> void:
	Transition.change_scene(self,"MainMenu")

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
