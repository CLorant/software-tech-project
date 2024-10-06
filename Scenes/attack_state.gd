extends Node

class_name AttackState

var player = Global.get_player()
var attack_counter = 1

func enter_state():
	print("Entering Attack state")
	player.animated_sprite.play("attack_horizontal_" + str(attack_counter))
	
	await player.animated_sprite.animation_finished
	
	attack_counter = attack_counter % 2 + 1
	
	player.state_manager.set_state("IdleState")

func update_state(_delta):
	pass

func exit_state():
	print("Exiting Attack state")
