extends Node
class_name CrouchState

var player = Global.get_player()

func enter_state():
	print("Entering Crouch state")

func update_state(_delta):
	if not Input.is_action_pressed("crouch"):
		player.state_manager.set_state("IdleState")
	elif Input.is_action_just_pressed("attack"):
		player.state_manager.set_state("AttackState")

	var direction = Input.get_axis("move_left", "move_right")
	player.animated_sprite.play("crouch" if direction == 0 else "crouch_walk")
	
	if direction < 0:
		player.animated_sprite.flip_h = true
	elif direction > 0:
		player.animated_sprite.flip_h = false

	player.velocity.x = player.crouch_speed * direction
	player.move_and_slide()

func exit_state():
	print("Exiting Crouch state")
