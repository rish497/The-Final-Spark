extends CanvasLayer
@onready var start: Button = $start/start
@onready var pushability: AnimatedSprite2D = $pushability
var reload := false
@onready var color_rect: Sprite2D = $NewPiskel33_png
var spin_tween: Tween
func _ready() -> void:
	color_rect.visible = false
	pushability.visible = false

	GameManager.do_push_ability = false
	GameManager.pushabilityfinished = true


var reloading := false

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		if GameManager.tutorial == false:
			return
		start.emit_signal("pressed")
	if GameManager.pushability == true:
		if GameManager.pause:
			pushability.speed_scale = 0
		else:
			pushability.speed_scale = GameManager.reloadspeed
		if GameManager.pause or GameManager.tto:
			return
		if GameManager.pushability:
			pushability.visible = true
		if Input.is_action_just_pressed("pushability") and reload:
			GameManager.do_push_ability = true
			color_rect.visible = false
		if GameManager.pushabilityfinished and !reloading:
				color_rect.visible = false
				GameManager.pushabilityfinished = false
				start_reload()
		if GameManager.do_push_ability:
			pushability.play("no reload")

	
func start_reload():
	reloading = true
	reload = false
	pushability.speed_scale = GameManager.reloadspeed
	pushability.play("reloading")
	await pushability.animation_finished
	pushability.play("fullyreloaded")
	start_spin()
	reload = true
	reloading = false


func start_spin():

	color_rect.visible = true

	spin_tween = create_tween()
	spin_tween.set_loops()

	spin_tween.tween_property(
		color_rect,
		"rotation_degrees",
		color_rect.rotation_degrees + 360,
		1.2
	)


func stop_spin():

	if spin_tween:
		spin_tween.kill()
		spin_tween = null

	color_rect.rotation_degrees = 0
