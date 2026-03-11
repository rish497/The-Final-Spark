extends Node2D

@export var speed := 200

func _process(delta):
	position.y += speed * delta
