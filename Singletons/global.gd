extends Node

# Global variable to store the player node
var player: CharacterBody2D = null
var gravity = 900
var starting_position: Vector2

# Method to set the player node
func set_player(new_player: CharacterBody2D) -> void:
	player = new_player

# Method to get the player node (optional)
func get_player() -> CharacterBody2D:
	return player

func set_starting_position() -> void:
	starting_position = player.position

func get_starting_position() -> Vector2:
	return starting_position
