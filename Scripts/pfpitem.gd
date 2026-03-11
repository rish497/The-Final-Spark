extends Panel
@onready var label_3: ColorRect = $ColorRect
@export var itemname: String
@export var itemimage: Texture2D
@export var itemprice: String
@export var itemdescription: String
@onready var label_4: ColorRect = $ColorRect2
@onready var spend: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	$Label.text = itemname
	$TextureRect.texture = itemimage
	$PanelContainer/HBoxContainer/Label.text = itemprice
	$Label2.text = itemdescription
	
func _process(delta: float) -> void:
	if GameManager.money >= int(itemprice):
		label_3.visible = false
	else:
		label_3.visible = true
	if label_4.visible == true:
			label_3.visible = false
		
		

func _on_button_pressed() -> void:
	spend.play()
	GameManager.play_button_click()
	if GameManager.money>=int(itemprice):
		GameManager.loose_money_smooth(int(itemprice))
		label_4.visible = true
		if itemname == "T.P. TO SELL":
			pass
		elif itemname == "SELL AT SPOT":
			pass
		elif itemname == "Cheap Walking":
			pass
		elif itemname == "Valuable Pigs":
			pass
		elif itemname == "Walking is free (5min)":
			pass
		elif itemname == "2x Everything (5min)":
			pass
	else:
		pass
		
			

	
		
