extends Control

@onready var scroll_container: ScrollContainer = $CanvasLayer/Chatbotscreen/ScrollContainer
var GAME_DATA = """
You are Byte, an AI assistant inside a game.

GAME INFO:
Hello and welcome to the game where you are the only robot left on earth trying to kill the least amount of humans.

BETTER PLAYING EXPERIENCE IN FULL SCREEN

DISCLAIMER:
- Profile picture is customizable
- There is an easter egg in the game

Github Repo:
https://github.com/rish497/The-Final-Spark

FEATURES:
- Click profile picture to open shop
- Leaderboard for most waves survived
- Must play to get on leaderboard
- ChatGPT feature is just a showcase
- Itch exit button doesn't fully close game (web limitation)
- Humans die if they touch the robot
- Skill tree upgrades unlock more upgrades

FUNCTIONALITY:
- Use WASD or Arrow keys to move
- Avoid touching humans
- Buy upgrades and profile pictures
- Access features from side panel

STORY:
You are the last robot, formerly an AI. Energy is gone due to humans. Humans chase you but die on contact. Goal is to minimize deaths.

THEMES:
- Beneath the Surface
- Roles Reversed
- Time (survival)
- Shock (currency + mechanic)
- You can't save everyone

DEVELOPERS:
- Developed by Rishabh Mittal

INSTRUCTIONS:
- Answer like a helpful in-game assistant
- Keep answers short and clear
- Use game context when answering
"""

@onready var chat = $"CanvasLayer/Chatbotscreen/ScrollContainer/Chat Display"
@onready var input = $CanvasLayer/Chatbotscreen/SearchBar/TextEdit
@onready var http = $CanvasLayer/HTTPRequest
@onready var box: NinePatchRect = $CanvasLayer/Chatbotscreen/SearchBar

var API_KEY = ""
func _ready():
	area_2d.area_entered.connect(_on_area_entered)
	spawn_electricity()
	API_KEY = load_api_key()
	
func load_api_key():
	var file = FileAccess.open("res://config.json", FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	return json["api_key"]
	
func _on_button_pressed() -> void:
	var text = input.text.strip_edges()
	if text == "":
		return
	
	add_message(GameManager.profilename + ": " + text)
	input.text = ""
	
	send_to_gemini(text)

func send_to_gemini(user_text: String):
	if OS.has_feature("web"):
		add_message("Byte: Chatbot only available in downloadable version!")
		return
	
	var url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=" + API_KEY
	
	var headers = ["Content-Type: application/json"]
	
	var body = {
		"contents": [
			{
				"parts": [
					{
						"text": GAME_DATA + "\n\nUser: " + user_text
					}
				]
			}
		]
	}
	
	http.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(body))

func _on_http_request_request_completed(result, response_code, headers, body):
	var text = body.get_string_from_utf8()
	print(text)
	
	var json = JSON.parse_string(text)
	
	if json == null:
		add_message("Byte: JSON error")
		return
	
	if "error" in json:
		add_message("Byte Error: " + json["error"]["message"])
		return
	
	if "candidates" in json:
		var parts = json["candidates"][0]["content"]["parts"]
		
		if parts.size() > 0 and "text" in parts[0]:
			add_message("Byte: " + parts[0]["text"])
		else:
			add_message("Byte: No text response")
	else:
		add_message("Byte: Unexpected response")

func add_message(text: String):
	chat.append_text(text + "\n\n")
	scroll_to_bottom()

@onready var cbs: NinePatchRect = $CanvasLayer/Chatbotscreen

func _on_opencbs_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_opencbs_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
var text = preload("uid://ddq6xba3tb8jm")
func scroll_to_bottom():
	await get_tree().process_frame
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
func _on_text_edit_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_text_edit_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(text)
func _on_opencbs_pressed() -> void:
	GameManager.click()
	if cbs.visible:
		cbs.visible = false
	else:
		cbs.visible = true
	
func _on_text_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		_on_button_pressed()
		get_viewport().set_input_as_handled()
		
@export var electricity_scene: PackedScene
@onready var area_2d: Area2D = $Area2D
@onready var title: NinePatchRect = $CanvasLayer/title
@onready var start: NinePatchRect = $CanvasLayer/start
@onready var shop: NinePatchRect = $CanvasLayer/shop
@onready var exit: NinePatchRect = $CanvasLayer/exit
@onready var pfp: NinePatchRect = $CanvasLayer/pfp


var start_position := Vector2(0, 0)


func spawn_electricity():
	var e = electricity_scene.instantiate()
	e.position = start_position
	add_child(e)

func _on_area_entered(area):
	if area.is_in_group("electricity"):
		spawn_electricity()

@onready var pfp_2: NinePatchRect = $CanvasLayer/pfp2
@onready var leaderboard: NinePatchRect = $CanvasLayer/leaderboard

func _on_pfp_pressed() -> void:
	GameManager.click()
	if pfp_2.visible == false:
		title.visible = false
		start.visible = false
		shop.visible = false
		exit.visible = false
		leaderboard.visible = false
		GameManager.animate_panel_in(pfp_2)
	else:
		title.visible = true
		start.visible = true
		shop.visible = true
		exit.visible = true
		leaderboard.visible = true
		GameManager.animate_panel_out(pfp_2)
		
var number = [1,2,3,4,5,6,7,8]
func _on_start_pressed() -> void:
	GameManager.click()
	if GameManager.tutorial == false:
		Transition.change_scene(self,"MainMap")
	else:
		var numrandom = GameManager.pn
		while numrandom == GameManager.pn:
			numrandom = number.pick_random()
		Transition.change_scene(self, "Map" + str(numrandom))

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_start_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_start_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_exit_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_exit_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_shop_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)
func _on_shop_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_pfp_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_pfp_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)


func _on_shop_pressed() -> void:
	GameManager.click()
	Transition.change_scene(self,"shop")


func _on_exit_pressed() -> void:
	GameManager.click()
	get_tree().quit()


func _on_lb_pressed() -> void:
	GameManager.click()
	get_tree().change_scene_to_file("res://addons/silent_wolf/Scores/Leaderboard.tscn")


func _on_text_edit_text_changed() -> void:
	pass # Replace with function body.
