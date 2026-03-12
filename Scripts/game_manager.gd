extends Node
var humans:int
var money:int = 10000
var wave:int = 1

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
