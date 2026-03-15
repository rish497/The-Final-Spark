extends Node
var strength = 90
var humans: int = 1
var money: int = 0
var wave: int = 1
var shocktotal:int = 1000000000
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
var spawnrate: int = 5
var sr = false


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
