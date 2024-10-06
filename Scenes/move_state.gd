extends Node

class_name MoveState

var player = Global.get_player()

func enter_state():
	print("Entering Move state")

func update_state(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	player.animated_sprite.play("idle" if direction == 0 else "run")
	
	if direction:
		player.velocity.x = direction * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, player.deceleration, player.speed)
	
	if direction < 0:
		player.animated_sprite.flip_h = true
	elif direction > 0:
		player.animated_sprite.flip_h = false

	player.move_and_slide()

	if direction == 0:
		player.state_manager.set_state("IdleState")
	elif Input.is_action_just_pressed("jump"):
		player.state_manager.set_state("JumpState")
	elif Input.is_action_pressed("crouch"):
		player.state_manager.set_state("CrouchState")
	elif Input.is_action_just_pressed("attack"):
		player.state_manager.set_state("AttackState")
	elif player.can_dash():
		player.state_manager.set_state("DashState")

func exit_state():
	print("Exiting Move state")
