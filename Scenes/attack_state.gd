extends Node

class_name AttackState

var attack_timer: Timer

func enter_state():
	print("Entering Attack state")

func update_state(_delta, player):
	# Itt lehetne a támadás animáció kezelése is
	
	if Input.is_action_pressed("attack"):
		player.animated_sprite.play("attack_horizontal")
	else:
		player.state_manager.set_state("IdleState")

func exit_state():
	print("Exiting Attack state")
