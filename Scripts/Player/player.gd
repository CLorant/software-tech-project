extends CharacterBody2D

var state_manager: StateManager
@export var speed = 200.0
@export_range(0, 1) var deceleration = 0.1

@export var jump_force = -400
@export_range(0, 1) var decelerate_on_jump_release = 0.5

@export var crouch_speed = speed / 2

var max_health = 100
@export var health = 0
@export var damage = 20

@export var dash_speed = speed * 3
@export var dash_max_distance = 100.0
@export var dash_curve : Curve
@export var dash_cooldown = 5.0

@export var double_jump_cooldown = 5.0

var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

var double_jump_timer = 0
var wall_jump_timer = 0

var skill_settings = {}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: CollisionShape2D = $AttackArea/CollisionShape2D

func _ready():
	### For testing, delete later
	ConfigFileHandler.save_skill_setting("has_dash", true)
	ConfigFileHandler.save_skill_setting("has_double_jump", true)
	ConfigFileHandler.save_skill_setting("has_wall_jump", true)
	###
	
	health = max_health
	
	Global.set_player(self)
	
	state_manager = StateManager.new()
	
	state_manager.add_state("IdleState", IdleState.new())
	state_manager.add_state("MoveState", MoveState.new())
	state_manager.add_state("JumpState", JumpState.new())
	state_manager.add_state("CrouchState", CrouchState.new())
	state_manager.add_state("AttackState", AttackState.new())
	state_manager.add_state("DeathState", DeathState.new())
	
	state_manager.add_state("DashState", DashState.new())
	
	state_manager.set_state("IdleState")
	
	skill_settings = ConfigFileHandler.load_skill_settings()
	

func can_dash():
	var direction = Input.get_axis("move_left", "move_right")
	return Input.is_action_just_pressed("dash") and direction != 0 and not is_dashing and dash_timer <= 0 and skill_settings.has_dash

func can_double_jump():
	return Input.is_action_just_pressed("jump") and double_jump_timer <= 0 and skill_settings.has_double_jump
	
func can_wall_jump():
	return is_on_wall() and wall_jump_timer <= 0 and skill_settings.has_wall_jump

func _physics_process(delta):
	if health == 0 and state_manager.current_state is not DeathState:
		state_manager.set_state("DeathState")
	
	if not is_on_floor():
		velocity.y += Global.gravity * delta

	state_manager.update_state(delta)
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction < 0:
		animated_sprite.flip_h = true
		attack_area.position.x = -abs(attack_area.position.x)
	elif direction > 0:
		animated_sprite.flip_h = false
		attack_area.position.x = abs(attack_area.position.x)
	
	if dash_timer > 0:
		dash_timer -= delta
		
	if double_jump_timer > 0:
		double_jump_timer -= delta
	
	move_and_slide()

func inflict_damage(enemy_damage):
	health = max(0, health - enemy_damage)
	print("Player health: " + str(health))

func reset_health():
	health = max_health

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "death":
		reset_health()
		position = Global.get_starting_position()
		state_manager.set_state("IdleState")
	elif animated_sprite.animation == "attack_horizontal_1" or animated_sprite.animation == "attack_horizontal_2" or animated_sprite.animation == "crouch_attack":
		attack_area.disabled = true
		if Input.is_action_pressed("crouch"):
			state_manager.set_state("CrouchState")
		else:
			state_manager.set_state("IdleState")
