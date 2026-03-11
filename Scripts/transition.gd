extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer


var last_scene_name: String
var scene_dir_path := "res://Scenes/"
func _ready() -> void:
	self.visible = false

func change_scene(from: Node, to_scene_name: String) -> void:
	self.visible=true
	last_scene_name = from.name

	animation.play("AnimateIN")
	await animation.animation_finished

	var full_path := scene_dir_path + to_scene_name + ".tscn"
	get_tree().change_scene_to_file(full_path)

	animation.play_backwards("AnimateIN")
	await animation.animation_finished
	self.visible = false
