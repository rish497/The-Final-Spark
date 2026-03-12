extends CharacterBody2D
var speed = 70
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var target: CharacterBody2D = $"../CharacterBody2D"

func _process(delta: float) -> void:
	var direction = (target.position-position).normalized()
	velocity = direction * speed
	move_and_slide()
	update_animation(direction)
	

func update_animation(dir: Vector2):
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
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("robot"):
		await shock_effect()
		queue_free()
		GameManager.humans -= 1
		


func shock_effect():
	var tween = create_tween()

	for i in range(4):
		tween.tween_property(self, "rotation_degrees", 10, 0.05)
		tween.tween_property(self, "rotation_degrees", -10, 0.05)

	tween.tween_property(self, "rotation_degrees", 0, 0.05)

	return tween.finished
