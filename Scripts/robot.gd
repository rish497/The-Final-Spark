extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed := 100

func _physics_process(delta):

	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	velocity = input_dir.normalized() * speed
	move_and_slide()

	update_animation(input_dir)


func update_animation(dir: Vector2):

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
