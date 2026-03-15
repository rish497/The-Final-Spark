extends NinePatchRect
@onready var price: Label = $PanelContainer/HBoxContainer/Label
@onready var ds: Label = $Label2
@onready var title: Label = $Label
@export var itemname: String
@export var itemprice: int
@export var description: String
@export var button: Button
@export var notenough: Label
@export var success: Label
func _ready() -> void:
	title.text = itemname
	price.text = str(itemprice)
	ds.text = description
	if button:
		button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if itemprice <= GameManager.shocktotal:
		fadeio(success)
		GameManager.shocktotal -= itemprice
		button.visible = false
		if itemname == "Abilities":
			GameManager.abilities = true
		elif itemname == "Speed I":
			GameManager.speed +=5
			GameManager.s1 = true
		elif itemname == "Speed II":
			GameManager.speed +=5
			GameManager.s2 = true
		elif itemname == "Speed III":
			GameManager.speed +=5
			GameManager.s3 = true
		elif itemname == "Speed IV":
			GameManager.speed +=5
			GameManager.s4 = true
		elif itemname == "Speed V":
			GameManager.speed +=5
			GameManager.s5 = true
		elif itemname == "Shock Burst":
			GameManager.pushability = true
		elif itemname == "Minor Repulse":
			GameManager.ps1 = true
			GameManager.strength = 150
		elif itemname == "Force Repulse":
			GameManager.ps2 = true
			GameManager.strength = 200
		elif itemname == "Overload Repulse":
			GameManager.ps3 = true
			GameManager.strength = 250
		elif itemname == "Cooling Optimization":
			GameManager.pr1 = true
			GameManager.reloadspeed = 3
		elif itemname == "Hyper Recharge":
			GameManager.pr2 = true
			GameManager.reloadspeed = 4
		elif itemname == "Debuff Humans":
			GameManager.survival = true
		elif itemname == "Walking Speed":
			GameManager.hs = true
			GameManager.humanspeed = 85
		elif itemname == "Spawn Rate":
			GameManager.sr = true
			GameManager.spawnrate = 2
			
		
		
		
			
	elif itemprice > GameManager.shocktotal:
		fadeio(notenough)

func fadeio(panel):
	GameManager.fade_in(panel, 1)
	await get_tree().create_timer(1).timeout
	await GameManager.fade_out(panel, 1)
	
