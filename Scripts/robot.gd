extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var c1: CollisionShape2D = $CollisionShape2D
@onready var c2: CollisionShape2D = $CollisionShape2D2
@onready var c3: CollisionShape2D = $Area2D2/CollisionShape2D2
@onready var c4: CollisionShape2D = $Area2D2/CollisionShape2D3
@onready var area_2d_2: Area2D = $Area2D2

var speed := GameManager.speed
var pushing := false
var step_timer := 0.0
var step_interval := 0.35
func _process(_delta):
	if GameManager.do_push_ability and !pushing:
		pushing = true
		pushability()
			
@onready var audio_stream_player_8: AudioStreamPlayer = $AudioStreamPlayer8

func pushability():
	sprite.play("pushup")
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	c1.set_deferred("disabled", true)
	c2.set_deferred("disabled", true)
	c3.set_deferred("disabled", true)
	c4.set_deferred("disabled", true)
	area_2d_2.monitoring = false
	area_2d_2.monitorable = false
	await sprite.animation_finished
	await get_tree().create_timer(.5).timeout
	sprite.play("pushdown")
	GameManager.nowpushbackhumans = true
	audio_stream_player_8.play()
	await get_tree().create_timer(.1).timeout
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	c1.set_deferred("disabled", false)
	c2.set_deferred("disabled", false)
	c3.set_deferred("disabled", false)
	c4.set_deferred("disabled", false)
	area_2d_2.monitoring = true
	area_2d_2.monitorable = true
	GameManager.do_push_ability = false
	GameManager.pushabilityfinished = true
	GameManager.nowpushbackhumans = false
	pushing = false
func _physics_process(delta):

	if GameManager.pause:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if pushing:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	velocity = input_dir.normalized() * speed
	move_and_slide()

	update_animation(input_dir)

	if input_dir != Vector2.ZERO and !pushing:
		if !GameManager.humanwalkingsound.playing:
			GameManager.humanwalkingsound.play()
	else:
		if GameManager.humanwalkingsound.playing:
			GameManager.humanwalkingsound.stop()
		
func update_animation(dir: Vector2):
	if pushing:
		return
	if dir == Vector2.ZERO:
		play_idle()
		return
	var angle = dir.angle()
	var deg = rad_to_deg(angle)

	sprite.flip_h = false

	if deg >= -22.5 and deg < 22.5:
		sprite.play("ER")

	elif deg >= 22.5 and deg < 67.5:
		sprite.play("SER")

	elif deg >= 67.5 and deg < 112.5:
		sprite.play("SR")

	elif deg >= 112.5 and deg < 157.5:
		sprite.play("SER")
		sprite.flip_h = true

	elif deg >= 157.5 or deg < -157.5:
		sprite.play("ER")
		sprite.flip_h = true

	elif deg >= -157.5 and deg < -112.5:
		sprite.play("NWR")

	elif deg >= -112.5 and deg < -67.5:
		sprite.play("NR")

	elif deg >= -67.5 and deg < -22.5:
		sprite.play("NWR")
		sprite.flip_h = true
		
func play_idle():

	var anim = sprite.animation

	if anim.ends_with("R"):
		anim = anim.replace("R", "D")

	sprite.play(anim)


		
