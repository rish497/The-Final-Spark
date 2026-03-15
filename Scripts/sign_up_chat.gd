extends NinePatchRect
@onready var text_edit: TextEdit = $SearchBar/TextEdit
@onready var selector: Label = $selector
@onready var color_rect: ColorRect = $"../ColorRect"
@onready var te: TextEdit = $"../Textpage/SearchBar/TextEdit"


func _on_button_pressed() -> void:
	GameManager.click()
	GameManager.p1 = true
	GameManager.p2 = false
	GameManager.p3 = false
	GameManager.p4 = false
	GameManager.p5 = false
	GameManager.p6 = false
	selector.visible = true
	selector.position = Vector2(40,242.5)

func _on_pfp_2_pressed() -> void:
	GameManager.click()
	GameManager.p1 = false
	GameManager.p2 = true
	GameManager.p3 = false
	GameManager.p4 = false
	GameManager.p5 = false
	GameManager.p6 = false
	selector.visible = true
	selector.position = Vector2(192.5,242.5)

@onready var sign_up_chat: NinePatchRect = $"."

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)

func _on_signupsubmit_pressed() -> void:
	GameManager.click()
	GameManager.profilename = text_edit.text
	print(text_edit.text)
	if text_edit.text == "":
		pass
	else:
		GameManager.animate_panel_out(sign_up_chat)
		GameManager.signupdone = true
		color_rect.visible = false
		te.editable = true
