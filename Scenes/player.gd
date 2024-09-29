extends CharacterBody2D

var state_manager: StateManager # A StateManager példány
var speed = 200

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# StateManager példányosítása
	state_manager = StateManager.new()
	
	# animated_sprite.play("idle")
	
	# Állapotok hozzáadása a StateManagerhez
	state_manager.add_state("IdleState", IdleState.new())
	state_manager.add_state("MoveState", MoveState.new())
	state_manager.add_state("JumpState", JumpState.new())
	state_manager.add_state("CrouchState", CrouchState.new())
	state_manager.add_state("AttackState", AttackState.new())
	
	# Kezdeti állapot beállítása
	state_manager.set_state("IdleState")

# A physics_process használata az állapot frissítéséhez
func _physics_process(delta):
	state_manager.update_state(delta, self)
	#if animated_sprite.animation == "jump" and not animated_sprite.is_playing():
		#state_manager.set_state("IdleState")
	#elif animated_sprite.animation == "run" and not animated_sprite.is_playing():
		#state_manager.set_state("IdleState")
	#elif animated_sprite.animation == "attack_horizontal" and not animated_sprite.is_playing():
		#state_manager.set_state("IdleState")  # Visszatérés idle állapotba támadás után







# Régi kód

#const SPEED = 200.0
#const JUMP_VELOCITY = -400.0
#
#
#@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

#func _physics_process(delta: float) -> void:
	#
	#var is_attacking
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Direction input. (-1, 0, 1)
	#var direction := Input.get_axis("move_left", "move_right")
	#
	##Flip the sprite
	#if direction > 0:
		#animated_sprite.flip_h = false
	#elif direction < 0:
		#animated_sprite.flip_h = true
	#
	##Animations.
	#if is_on_floor():
		#if direction == 0:
			#animated_sprite.play("idle")
		#else:
			#animated_sprite.play("run")
	#else:
		#if velocity.y <= 0:
			#animated_sprite.play("jump")
		#elif velocity.y > 0:
			#animated_sprite.play("fall")
	#
	#if Input.is_action_just_pressed("attack"):
		#is_attacking = true
		#animated_sprite.play("attack_horizontal")	
		#
	#
	##Apply movement
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
