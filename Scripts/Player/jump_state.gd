extends Node
class_name JumpState

var player = Global.get_player()
var velocity = Vector2()
var jump_grace_time = 0.1
var grace_timer = 0.0

func enter_state():
	print("Entering Jump state")
	velocity.y = player.jump_force
	grace_timer = jump_grace_time

func update_state(delta):
	player.animated_sprite.play("jump" if velocity.y < 0 else "fall")
	
	velocity.y += Global.gravity * delta
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= player.decelerate_on_jump_release
	
	if player.is_on_ceiling():
		velocity.y = Global.gravity * delta
	
	player.velocity.y = velocity.y
	
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * direction
	
	if grace_timer > 0:
		grace_timer -= delta
	else:
		if player.is_on_floor():
			player.state_manager.set_state("IdleState")
		elif Input.is_action_just_pressed("attack"):
			player.state_manager.set_state("AttackState")
		elif player.can_dash():
			player.state_manager.set_state("DashState")
		elif player.can_double_jump():
			player.double_jump_timer = player.double_jump_cooldown
			player.state_manager.set_state("JumpState")

func exit_state():
	print("Exiting Jump state")
