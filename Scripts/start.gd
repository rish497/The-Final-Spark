extends NinePatchRect
@onready var pause_icon: Label = $PauseIcon
@onready var play_icon: Label = $PlayIcon

@onready var pausemenu: NinePatchRect = $"../pausemenu"
func _ready() -> void:
	pause_icon.visible = true
	play_icon.visible = false
func _on_start_pressed() -> void:
	if pausemenu.visible == false:
		GameManager.animate_panel_in(pausemenu)
		GameManager.timer = false
		GameManager.pause = true
		GameManager.play = false
		pause_icon.visible = false
		play_icon.visible = true
	elif pausemenu.visible == true:
		GameManager.animate_panel_out(pausemenu)
		GameManager.timer = true
		GameManager.pause = false
		GameManager.play = true
		pause_icon.visible = true
		play_icon.visible = false

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_start_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_start_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
