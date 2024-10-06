extends Node
class_name DashState

var player = Global.get_player()

var velocity = Vector2()

func enter_state():
	var direction = Input.get_axis("move_left", "move_right")
	
	player.is_dashing = true
	player.dash_start_position = player.position.x
	player.dash_direction = direction
	player.dash_timer = player.dash_cooldown
	
	velocity.y = player.velocity.y
	
	print("Entering Dash state")

func update_state(delta):
	velocity.y += Global.gravity * delta
	
	if player.is_dashing:
		velocity.y = 0
		var current_distance = abs(player.position.x - player.dash_start_position)
		if current_distance >= player.dash_max_distance or player.is_on_wall():
			player.is_dashing = false
		else:
			player.animated_sprite.play("dash")
			player.velocity.x = player.dash_direction * player.dash_speed * player.dash_curve.sample(current_distance / player.dash_max_distance)
	
	if player.is_on_floor() and not player.is_dashing:
		player.state_manager.set_state("IdleState")
	# dash cooldown nem műkszik, falling javítása, csak vízszintesen lehessen dashelni
	elif not player.is_on_floor() and not player.is_dashing:
		var direction = Input.get_axis("move_left", "move_right")
		player.velocity.x = player.speed * direction
		player.animated_sprite.flip_h = direction < 0
	
		player.velocity.y = velocity.y

	player.move_and_slide()

func exit_state():
	print("Exiting Dash state")
