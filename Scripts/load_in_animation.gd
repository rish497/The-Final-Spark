extends Control

@onready var m_1: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/M1
@onready var r_1: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/R1
@onready var m_2: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/M2
@onready var r_2: HBoxContainer = $Textpage/ScrollContainer/VBoxContainer/R2
@onready var text_edit: TextEdit = $Textpage/SearchBar/TextEdit
@onready var scroll_container: ScrollContainer = $Textpage/ScrollContainer
@onready var label: Label = $Sidebar/VBoxContainer/HBoxContainer7/Label

@onready var r1_label: Label = $Textpage/ScrollContainer/VBoxContainer/R1/R1
@onready var r2_label: Label = $Textpage/ScrollContainer/VBoxContainer/R2/R2


var typing_speed := 0.02

func _ready() -> void:
	m_1.visible = false
	r_1.visible = false
	m_2.visible = false
	r_2.visible = false


func _on_button_pressed() -> void:
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

	else:
		if not m_1.visible:
			text_edit.placeholder_text = 'TYPE "MAKE NEW GAME"'
		else:
			text_edit.placeholder_text = 'TYPE "YES"'


func type_text(label: Label):
	var full_text = label.text
	label.text = ""

	for i in full_text.length():
		label.text += full_text[i]
		scroll_to_bottom()
		await get_tree().create_timer(typing_speed).timeout

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		_on_button_pressed()

func scroll_to_bottom():
	await get_tree().process_frame
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
