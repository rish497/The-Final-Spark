extends Control
@onready var speed_1: NinePatchRect = $Abilities2/Speed/Speed1
@onready var speed_2: NinePatchRect = $Abilities2/Speed/Speed2
@onready var speed_3: NinePatchRect = $Abilities2/Speed/Speed3
@onready var speed_4: NinePatchRect = $Abilities2/Speed/Speed4
@onready var speed_5: NinePatchRect = $Abilities2/Speed/Speed5
@onready var pushability: NinePatchRect = $Abilities2/PushAbility/Push
@onready var strength_1: NinePatchRect = $Abilities2/PushAbility/Strength/Strength1
@onready var strength_2: NinePatchRect = $Abilities2/PushAbility/Strength/Strength2
@onready var strength_3: NinePatchRect = $Abilities2/PushAbility/Strength/Strength3
@onready var reload_speed_1: NinePatchRect = $"Abilities2/PushAbility/Reload speed/ReloadSpeed1"
@onready var reload_speed_2: NinePatchRect = $"Abilities2/PushAbility/Reload speed/ReloadSpeed2"
@onready var humanspeed: NinePatchRect = $Survival2/humanspeed
@onready var spawnrate: NinePatchRect = $Survival2/spawnrate

func _ready() -> void:
	speed_1.visible = false
	speed_2.visible = false
	speed_3.visible = false
	speed_4.visible = false
	speed_5.visible = false
	pushability.visible = false
	strength_1.visible = false
	strength_2.visible = false
	strength_3.visible = false
	reload_speed_1.visible = false
	reload_speed_2.visible = false
	humanspeed.visible = false
	spawnrate.visible = false
	
func _process(delta: float) -> void:
	if GameManager.abilities:
		speed_1.visible = true
		pushability.visible = true
	if GameManager.s1:
		speed_2.visible = true
	if GameManager.s2:
		speed_3.visible = true
	if GameManager.s3:
		speed_4.visible = true
	if GameManager.s4:
		speed_5.visible = true
	if GameManager.pushability:
		GameManager.reloadspeed = 3
		strength_1.visible = true
		reload_speed_1.visible = true
	if GameManager.ps1:
		strength_2.visible = true
	if GameManager.ps2:
		strength_3.visible = true
	if GameManager.pr1:
		reload_speed_2.visible = true
	if GameManager.survival == true:
		humanspeed.visible = true
		spawnrate.visible = true
	
	
var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_exit_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_exit_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)	


func _on_exit_pressed() -> void:
	GameManager.click()
	Transition.change_scene(self, "MainMenu")
