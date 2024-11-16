extends Node

class_name AttackState

var player = Global.get_player()
var attack_counter = 1

func enter_state():
	print("Entering Attack state")
	player.animated_sprite.play("attack_horizontal_" + str(attack_counter))
	attack_counter = attack_counter % 2 + 1
	
	player.attack_area.disabled = false

func update_state(_delta):
	if player.is_on_floor():
		player.velocity.x = 0
	else:
		var direction = Input.get_axis("move_left", "move_right")
		player.velocity.x = player.crouch_speed * direction
		player.animated_sprite.play("attack_horizontal_1")
	
	if Input.is_action_pressed("crouch"):
		player.animated_sprite.play("crouch_attack")

func exit_state():
	print("Exiting Attack state")
