extends Node
var strength = 110
var humans: int = 1
var money: int = 0
var wave: int = 1
var shocktotal:int = 0
var timer: bool = false
var pause: bool = false
var play: bool = false
var death: bool = false
var time = 0
var besttime: int = 0
var tm: int = 0
var tto = true
var wb: int = 0
var wm: int = 0
var pushabilityfinished = true
var sb: int = 0
var sm: int = 0
var st: int = 0
var abilities = false
var pushability = false
var s1 = false
var s2 = false
var s3  = false
var s4  = false
var s5 = false
var ps1 = false
var ps2 = false
var ps3 = false
var pr1 = false
var pr2 = false
var reloadspeed:int = 2
var do_push_ability = false
var nowpushbackhumans = false
var speed:int = 100
var humanspeed:int = 93
var survival = false
var hs = false
var spawnrate: int = 15
var sr = false
var purchased_items := {}
var profilename: String
var p1 = false
var p2 = false
var p3 = false
var p4 = false
var p5 = false
var p6 = false
var signupdone = false
var tutorial = false
@onready var clicksound: AudioStreamPlayer = $AudioStreamPlayer
@onready var humanwalkingsound: AudioStreamPlayer = $AudioStreamPlayer3
@onready var robotwalkingsound: AudioStreamPlayer = $AudioStreamPlayer4
@onready var typesound: AudioStreamPlayer = $AudioStreamPlayer5
@onready var purchasesound: AudioStreamPlayer = $AudioStreamPlayer6
@onready var beepsound: AudioStreamPlayer = $AudioStreamPlayer7
@onready var bg_music: AudioStreamPlayer = $BgMusic
func click():
	clicksound.play()
func humanwalk():
	humanwalkingsound.play()
func robotwalking():
	robotwalkingsound.play()
func type():
	typesound.pitch_scale = randf_range(0.9, 1.1)
	typesound.play()
func purchase():
	purchasesound.play()
func beep():
	beepsound.play()
func bgmusic():
	bg_music.play()
func fade_in(node: CanvasItem, duration: float = .2):
	node.visible = true
	if node == null:
		return
	
	node.modulate.a = 0.0
	
	var tween = node.create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
func fade_out(node: CanvasItem, duration: float = .2):
	if node == null:
		return
	
	node.modulate.a = 1.0
	
	var tween = node.create_tween()
	tween.tween_property(node, "modulate:a", 0.0, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	node.visible = false
func move_to(node: Node, target_pos: Vector2, duration: float = .1):
	if node == null:
		return
	
	var tween = node.create_tween()

	if node is Node2D:
		tween.tween_property(node, "position", target_pos, duration)\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_IN_OUT)

	elif node is Control:
		tween.tween_property(node, "position", target_pos, duration)\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_IN_OUT)

func animate_panel_in(panel):
	panel.visible = true
	panel.scale = Vector2(0,0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.6)
	
func animate_panel_out(panel):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(0, 0), 0.6)
	await get_tree().create_timer(0.2).timeout
	panel.visible = false
var sound_counter := 0

func type_text(label: Label):
	var full_text = label.text
	label.text = ""
	for i in range(full_text.length()):
		label.text += full_text[i]
		if full_text[i] != " ":
			sound_counter += 1
			if sound_counter >= 2:
				type()
				sound_counter = 0
		await get_tree().create_timer(0.02).timeout
func _ready() -> void:
	print("Spawnrate:", GameManager.spawnrate)
	SilentWolf.configure({
		"api_key": "iXNVMVArkV22UrBQoZSU33u9Q0oODSG97KMhTnBH",
		"game_id": "thefinalspark",
		"log_level": 1
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainMenu.tscn"
	})

func savescore():
	SilentWolf.Scores.save_score(profilename, wb)
