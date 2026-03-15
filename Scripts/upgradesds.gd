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

var bought := false
func _ready() -> void:
	title.text = itemname
	price.text = str(itemprice)
	ds.text = description
	if button:
		button.pressed.connect(_on_button_pressed)
	check_if_bought()

func check_if_bought():
	if GameManager.purchased_items.get(itemname, false):
		bought = true
		button.visible = false
		
func _on_button_pressed():
	if itemprice <= GameManager.shocktotal:
		GameManager.purchase()
		bought = true
		button.visible = false
		GameManager.purchased_items[itemname] = true
		fadeio(success)
		GameManager.shocktotal -= itemprice
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
			GameManager.strength = 200
		elif itemname == "Force Repulse":
			GameManager.ps2 = true
			GameManager.strength = 250
		elif itemname == "Overload Repulse":
			GameManager.ps3 = true
			GameManager.strength = 300
		elif itemname == "Cooling Optimization":
			GameManager.pr1 = true
			GameManager.reloadspeed = 5
		elif itemname == "Hyper Recharge":
			GameManager.pr2 = true
			GameManager.reloadspeed = 7
		elif itemname == "Debuff Humans":
			GameManager.survival = true
		elif itemname == "Walking Speed":
			GameManager.hs = true
			GameManager.humanspeed = 85
		elif itemname == "Spawn Rate":
			GameManager.sr = true
			GameManager.spawnrate = 2
	elif itemprice > GameManager.shocktotal:
		GameManager.click()
		fadeio(notenough)

func fadeio(panel):
	GameManager.animate_panel_in(panel)
	await get_tree().create_timer(1).timeout
	await GameManager.animate_panel_out(panel)
	
