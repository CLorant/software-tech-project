extends Area2D

const FILE_BEGIN = "res://Scenes/level_"
const FILE_END = ".tscn"

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("bonfire")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		
		var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_END
		call_deferred("_change_scene", next_level_path)

func _change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
