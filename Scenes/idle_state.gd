extends Node

class_name IdleState

func enter_state():
	print("Entering Idle state")

func update_state(_delta, player):
	player.animated_sprite.play("idle")
	
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		player.state_manager.set_state("MoveState")
	elif Input.is_action_just_pressed("jump"):
		player.state_manager.set_state("JumpState")
	elif Input.is_action_pressed("crouch"):
		player.state_manager.set_state("CrouchState")
	elif Input.is_action_just_pressed("attack"):
		player.state_manager.set_state("AttackState")


func exit_state():
	pass
	
