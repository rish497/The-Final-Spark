extends Panel
@onready var label_3: ColorRect = $ColorRect
@export var itemname: String
@export var itemimage: Texture2D
@export var itemprice: String
@export var itemdescription: String
@onready var spend: AudioStreamPlayer = $AudioStreamPlayer
@onready var button_2: Button = $PanelContainer2/Button2
@onready var equip: Label = $PanelContainer2/EQUIP
@onready var panel_container_2: PanelContainer = $PanelContainer2


func _ready():
	$Label.text = itemname
	$TextureRect.texture = itemimage
	$PanelContainer/HBoxContainer/Label.text = itemprice
	$Label2.text = itemdescription
	
func _process(delta: float) -> void:
	if GameManager.shocktotal >= int(itemprice):
		label_3.visible = false
	else:
		label_3.visible = true
var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)

func _on_button_pressed() -> void:
	if GameManager.shocktotal>=int(itemprice):
		GameManager.purchase()
		GameManager.shocktotal -= int(itemprice)
		panel_container_2.visible = true
		if itemname == "AMONG US":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = true
			GameManager.p4 = false
			GameManager.p5 = false
			GameManager.p6 = false
		elif itemname == "GHOST":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = false
			GameManager.p4 = true
			GameManager.p5 = false
			GameManager.p6 = false
		elif itemname == "BEAR":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = false
			GameManager.p4 = false
			GameManager.p5 = true
			GameManager.p6 = false
		elif itemname == "Darth Wader":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = false
			GameManager.p4 = false
			GameManager.p5 = false
			GameManager.p6 = true
	else:
		GameManager.click()
		pass


func _on_button_2_pressed() -> void:
	GameManager.click()
	if equip.text == "EQUIP":
		if itemname == "AMONG US":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = true
			GameManager.p4 = false
			GameManager.p5 = false
			GameManager.p6 = false
		elif itemname == "GHOST":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = false
			GameManager.p4 = true
			GameManager.p5 = false
			GameManager.p6 = false
		elif itemname == "BEAR":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = false
			GameManager.p4 = false
			GameManager.p5 = true
			GameManager.p6 = false
		elif itemname == "Darth Wader":
			GameManager.p1 = false
			GameManager.p2 = false
			GameManager.p3 = false
			GameManager.p4 = false
			GameManager.p5 = false
			GameManager.p6 = true
		
