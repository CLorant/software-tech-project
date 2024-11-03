extends Node

class_name EnemyChaseState

var player = null
var player_chase = false

#if player_chase:
		#animated_sprite.play("run")
		#position += (player.position - position) / speed
		#
		#if (player.position.x - position.x) < 0:
			#animated_sprite.flip_h = true
		#else:
			#animated_sprite.flip_h = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
