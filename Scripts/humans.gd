extends CharacterBody2D

var speed: float = GameManager.humanspeed
var push_force: Vector2 = Vector2.ZERO
var push_decay: float = 700
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var target: CharacterBody2D = $"../CharacterBody2D"
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
var was_pushed := false

func _ready():
	makepath()
	add_to_group("human")


func _physics_process(delta: float) -> void:
	if GameManager.pause:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	if GameManager.nowpushbackhumans and !was_pushed:
		var dist = global_position.distance_to(target.global_position)
		if dist < GameManager.strength: 
			var dir = (global_position - target.global_position).normalized()
			var falloff = 1.0 - (dist / GameManager.strength)
			push_force = dir * (falloff * 350)
			was_pushed = true
	
	if !GameManager.nowpushbackhumans:
		was_pushed = false
	
	if push_force.length() > 0:
		velocity = push_force
		push_force = push_force.move_toward(Vector2.ZERO, push_decay * delta)
		move_and_slide()

		return
		
	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	var next_point: Vector2 = nav_agent.get_next_path_position()
	var direction: Vector2 = (next_point - global_position).normalized()

	velocity = direction * speed
	move_and_slide()

	var anim_dir = (target.global_position - global_position).normalized()
	update_animation(anim_dir)


func makepath():
	nav_agent.target_position = target.global_position


func _on_timer_timeout() -> void:
	makepath()


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

func shock_effect():
	GameManager.electric()
	var tween = create_tween()

	for i in range(4):
		tween.tween_property(self, "rotation_degrees", 10, 0.05)
		tween.tween_property(self, "rotation_degrees", -10, 0.05)

	tween.tween_property(self, "rotation_degrees", 0, 0.05)

	return tween.finished
