extends Control
@onready var scroll_container: ScrollContainer = $Textpage/ScrollContainer

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

INSTRUCTIONS:
- Answer like a helpful in-game assistant
- Keep answers short and clear
- Use game context when answering
"""

@onready var chat = $"Chatbotscreen/ScrollContainer/Chat Display"
@onready var input = $Chatbotscreen/SearchBar/TextEdit
@onready var http = $HTTPRequest
@onready var box: NinePatchRect = $Chatbotscreen/SearchBar

var API_KEY = "AIzaSyAD2Svq5dp-Pd6A129Esdy5Nxug0TsWUBc"

func _on_button_pressed() -> void:
	var text = input.text.strip_edges()
	if text == "":
		return
	
	add_message(GameManager.profilename + ": " + text)
	input.text = ""
	
	send_to_gemini(text)

func send_to_gemini(user_text: String):
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
@onready var cbs: NinePatchRect = $Chatbotscreen

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_start_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_start_mouse_exited() -> void:
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
func _on_start_pressed() -> void:
	GameManager.click()
	if cbs.visible:
		cbs.visible = false
	else:
		cbs.visible = true
	
func _on_text_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		_on_button_pressed()
		get_viewport().set_input_as_handled()
