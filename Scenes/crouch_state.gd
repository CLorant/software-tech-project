extends Node

class_name CrouchState

func enter_state():
	print("Entering Crouch state")

func update_state(_delta, player):
	if not Input.is_action_pressed("crouch"):
		player.state_manager.set_state("IdleState")  # Ha a játékos felengedi a guggolás gombot, visszatérünk az Idle állapotba
	elif Input.is_action_just_pressed("attack"):
		player.state_manager.set_state("AttackState")  # Guggolásból támadhatunk is
	
	var velocity = Vector2()
	var crouchSpeed = player.speed / 2
	
	# Mozgás balra vagy jobbra
	if Input.is_action_pressed("move_right"):
		velocity.x += crouchSpeed
		player.animated_sprite.play("crouch_walk")
		player.animated_sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x -= crouchSpeed
		player.animated_sprite.play("crouch_walk")
		player.animated_sprite.flip_h = true
	else:
		player.animated_sprite.play("crouch")

	player.velocity.x = velocity.x 
	player.move_and_slide()

func exit_state():
	print("Exiting Crouch state")
