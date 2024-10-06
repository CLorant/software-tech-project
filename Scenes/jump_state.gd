extends Node
class_name JumpState

var player = Global.get_player()
var velocity = Vector2()

func enter_state():
	print("Entering Jump state")
	velocity.y = player.jump_force

func update_state(delta):
	player.animated_sprite.play("jump" if velocity.y < 0 else "fall")

	velocity.y += Global.gravity * delta
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= player.decelerate_on_jump_release
	
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * direction
	player.animated_sprite.flip_h = direction < 0
	
	player.velocity.y = velocity.y
	
	player.move_and_slide()
	
	if Input.is_action_pressed("dash"):
		player.state_manager.set_state("DashState")
	
	if player.is_on_floor():
		player.state_manager.set_state("IdleState")
	elif Input.is_action_just_pressed("dash") and direction and not player.is_dashing and player.dash_timer <= 0:
		player.state_manager.set_state("DashState")

func exit_state():
	print("Exiting Jump state")
