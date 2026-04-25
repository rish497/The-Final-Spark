extends NinePatchRect
@onready var text_edit: TextEdit = $SearchBar/TextEdit
@onready var selector: Label = $selector
@onready var color_rect: ColorRect = $"../ColorRect"
@onready var te: TextEdit = $"../Textpage/SearchBar/TextEdit"
@onready var email: TextEdit = $email/TextEdit
@onready var confirmpassword: TextEdit = $confirmpassword/TextEdit
var regex = RegEx.new()
var mask_char = "•"



func _on_button_pressed() -> void:
	GameManager.click()
	GameManager.p1 = true
	GameManager.p2 = false
	GameManager.p3 = false
	GameManager.p4 = false
	GameManager.p5 = false
	GameManager.p6 = false
	selector.visible = true
	selector.position = Vector2(40.187,405.0)

func _on_pfp_2_pressed() -> void:
	GameManager.click()
	GameManager.p1 = false
	GameManager.p2 = true
	GameManager.p3 = false
	GameManager.p4 = false
	GameManager.p5 = false
	GameManager.p6 = false
	selector.visible = true
	selector.position = Vector2(192.687,405.0)

@onready var sign_up_chat: NinePatchRect = $"."
@onready var password: TextEdit = $Password2/TextEdit

var point = preload("res://Assets/New Piskel-13.png (5).png")
var arrow = preload("uid://df3gadbe4uqcs")
func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(point)
func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(arrow)

func _ready():
	
	var pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
	regex.compile(pattern)
	SilentWolf.Auth.sw_registration_complete.connect(_on_registration_complete)


func _on_registration_complete(sw_result: Dictionary) -> void:
	if sw_result.success:
		print("Registration succeeded!")
	else:
		print("Error: " + str(sw_result.error))
		
@onready var label: Label = $"../Label"
		
func _on_signupsubmit_pressed() -> void:
	GameManager.click()
	GameManager.profilename = text_edit.text
	var confirm_password = confirmpassword.text
	var emailentered = email.text
	var passwordentered = password.text
		
	if password.text == confirmpassword.text:
		pass
	else:
		confirmpassword.text = "Password Does Not Match!"
		return
	
	if regex.search(passwordentered):
		print("Valid Password")
		
	else:
		GameManager.fade_in(label)
		await get_tree().create_timer(3).timeout
		GameManager.fade_out(label)
		return
		
		
		
	print(text_edit.text)
	if text_edit.text == "":
		pass
	else:
		GameManager.animate_panel_out(sign_up_chat)
		GameManager.signupdone = true
		color_rect.visible = false
		te.editable = true
		SilentWolf.Auth.register_player(GameManager.profilename, emailentered, passwordentered, confirm_password)
