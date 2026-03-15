extends Control
@onready var label_2: Label = $Textpage/Label2
@onready var m_1: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/M1
@onready var r_1: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/R1
@onready var m_2: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/M2
@onready var r_2: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/R2
@onready var text_edit: TextEdit = $Textpage/SearchBar/TextEdit
@onready var scroll_container: ScrollContainer = $Textpage/ScrollContainer
@onready var label: Label = $Sidebar/VBoxContainer/HBoxContainer7/Label
@onready var sign_up_chat: NinePatchRect = $SignUpChat
@onready var color_rect: ColorRect = $ColorRect
var sometext := ""
@onready var r1_label: Label = $Textpage/ScrollContainer/VBoxContainer/R1/R1
@onready var r2_label: Label = $Textpage/ScrollContainer/VBoxContainer/R2/R2


var typing_speed := 0.02
func _process(delta: float) -> void:
	label_2.text = GameManager.profilename
func _ready() -> void:
	color_rect.visible = false
	sign_up_chat.visible = false
	m_1.visible = false
	r_1.visible = false
	m_2.visible = false
	r_2.visible = false


func _on_button_pressed() -> void:
	GameManager.click()
	if GameManager.signupdone == false:
		sometext = text_edit.text
		text_edit.editable = false
		text_edit.placeholder_text = sometext
		GameManager.animate_panel_in(sign_up_chat)
		color_rect.visible = true
		return
		
	var input_text = text_edit.text.to_lower()
	text_edit.text = ""
	text_edit.release_focus()

	if input_text == "make a new game":
		label.text = "Brand new game"
		m_1.visible = true
		r_1.visible = true
		text_edit.editable = false
		text_edit.placeholder_text = "ask anything"
		await type_text(r1_label)
		text_edit.editable = true
		text_edit.placeholder_text = 'Type "yes"'

	elif input_text == "yes":
		m_2.visible = true
		r_2.visible = true
		text_edit.editable = false
		text_edit.placeholder_text = "ask anything"
		await type_text(r2_label)
		await get_tree().create_timer(1).timeout
		Transition.change_scene(self,"MainMenu")
		GameManager.bgmusic()
	else:
		if not m_1.visible:
			text_edit.placeholder_text = 'Type "make a new game"'
		else:
			text_edit.placeholder_text = 'TYPE "YES"'


var sound_counter := 0

func type_text(label: Label):
	var full_text = label.text
	label.text = ""

	for i in full_text.length():
		label.text += full_text[i]

		if full_text[i] != " ":
			sound_counter += 1
			if sound_counter >= 2:
				GameManager.type()
				sound_counter = 0

		scroll_to_bottom()
		await get_tree().create_timer(typing_speed).timeout

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		if sign_up_chat.visible == true:
			pass
		else:
			_on_button_pressed()

func scroll_to_bottom():
	await get_tree().process_frame
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
var text = preload("uid://ddq6xba3tb8jm")
var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")

func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_text_edit_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_text_edit_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(text)
