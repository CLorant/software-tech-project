extends Node

class_name JumpState

var jump_force = -400  # Ugrási erő
var gravity = 900
var velocity = Vector2()

func enter_state():
	print("Entering Jump state")
	velocity.y = jump_force  # Alkalmazzuk az ugrási erőt

func update_state(_delta, player):
	velocity.y += gravity * _delta  # Gravitáció alkalmazása
	player.velocity.y = velocity.y
	player.move_and_slide()  # Karakter mozgatása ugrás közben
	
	# Animáció
	
	if player.velocity.y > 0:
		player.animated_sprite.play("jump")
	elif player.velocity.y < 0:
		player.animated_sprite.play("fall")
	
	var horizontal_velocity = 0
	if Input.is_action_pressed("move_right"):
		horizontal_velocity += player.speed  # Jobbra mozgás
		player.animated_sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		horizontal_velocity -= player.speed  # Balra mozgás
		player.animated_sprite.flip_h = true

	# A vízszintes sebességet beállítjuk
	player.velocity.x = horizontal_velocity

	if player.is_on_floor():
		player.state_manager.set_state("IdleState")  # Ha visszaér a földre, visszatérünk az idle állapotba

func exit_state():
	print("Exiting Jump state")
