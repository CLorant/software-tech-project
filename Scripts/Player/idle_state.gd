extends Node

class_name IdleState

var player = Global.get_player()

func enter_state():
	print("Entering Idle state")
	player.animated_sprite.play("idle")

func update_state(_delta):
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
