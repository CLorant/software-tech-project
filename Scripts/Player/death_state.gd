extends Node

class_name DeathState

var player = Global.get_player()

func enter_state():
	print("Entering Death state")
	player.animated_sprite.play("death")
	
func update_state(_delta):
	pass

func exit_state():
	print("Exiting Death state")
