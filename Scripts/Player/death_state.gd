extends Node

class_name DeathState

var player = Global.get_player()

func enter_state():
	print("Entering Death state")
	player.animated_sprite.play("death")
	
func update_state(_delta):
	player.reset_health()
	await player.animated_sprite.animation_finished
	player.position = Global.get_starting_position()
	player.state_manager.set_state("IdleState")

func exit_state():
	print("Exiting Death state")
