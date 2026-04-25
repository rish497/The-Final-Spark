extends NinePatchRect
@onready var panel_container: PanelContainer = $PanelContainer
@export var nameofachievement: String
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@export var deasc: String
@onready var label_3: Label = $Label3
@export var prize: String
@onready var slider: ColorRect = $Slider/ColorRect
@export var stat_type: String = "shock"
@export var target_value: int = 1000
func _ready() -> void:
	label.text = nameofachievement
	panel_container.visible = false
	label_2.text = deasc
	label_3.text = prize

func _process(delta: float) -> void:
	var current_value = 0
	
	if stat_type == "shock":
		current_value = GameManager.shocktotal
	elif stat_type == "wave":
		current_value = GameManager.wb

	var progress = clamp(float(current_value) / target_value, 0.0, 1.0)

	slider.size.x = progress * $Slider.size.x
	if nameofachievement == "On the way to the top!":
		if current_value >= target_value:
			panel_container.visible = true
			
@onready var claim: Label = $PanelContainer/Label

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_button_mouse_entered() -> void:
	if claimed == false:
		Input.set_custom_mouse_cursor(point)
	else:
		Input.set_custom_mouse_cursor(arrow)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
var claimed = false

func _on_button_pressed() -> void:
	if claimed == false:
		GameManager.shocktotal +=int(prize)
		GameManager.click()
		print(GameManager.shocktotal)
		claimed = true
		claim.text = "claimed"
	elif claimed:
		claim.text = "claimed"
