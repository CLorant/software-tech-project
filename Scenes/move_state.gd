extends Node

class_name MoveState

func enter_state():
	print("Entering Move state")

func update_state(_delta, player):
	# Animáció
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip the sprite
	
	if direction == 0:
		player.animated_sprite.play("idle")
	else:
		player.animated_sprite.play("run")
	
	var velocity = Vector2()

	# Mozgás balra vagy jobbra
	if Input.is_action_pressed("move_right"):
		velocity.x += player.speed
		player.animated_sprite.play("run")
		player.animated_sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x -= player.speed
		player.animated_sprite.play("run")
		player.animated_sprite.flip_h = true
	
	# Karakter mozgatása
	player.velocity.x = velocity.x 
	player.move_and_slide()
	
	# Visszaváltás Idle állapotba, ha nincs mozgás
	if not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		player.state_manager.set_state("IdleState")
	elif Input.is_action_just_pressed("jump"):
		player.state_manager.set_state("JumpState")
	elif Input.is_action_pressed("crouch"):
		player.state_manager.set_state("CrouchState")
	elif Input.is_action_just_pressed("attack"):
		player.state_manager.set_state("AttackState")

func exit_state():
	print("Exiting Move state")
