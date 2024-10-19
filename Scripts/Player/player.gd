extends CharacterBody2D

var state_manager: StateManager
@export var speed = 200.0
@export_range(0, 1) var deceleration = 0.1

@export var jump_force = -400
@export_range(0, 1) var decelerate_on_jump_release = 0.5

@export var crouch_speed = speed / 2

@export var dash_speed = speed * 3
@export var dash_max_distance = 100.0
@export var dash_curve : Curve
@export var dash_cooldown = 5.0

var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

var skill_settings = {}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	ConfigFileHandler.save_skill_setting("has_dash", true)
	Global.set_player(self)
	
	state_manager = StateManager.new()
	
	state_manager.add_state("IdleState", IdleState.new())
	state_manager.add_state("MoveState", MoveState.new())
	state_manager.add_state("JumpState", JumpState.new())
	state_manager.add_state("CrouchState", CrouchState.new())
	state_manager.add_state("AttackState", AttackState.new())
	
	state_manager.add_state("DashState", DashState.new())
	
	state_manager.set_state("IdleState")
	
	skill_settings = ConfigFileHandler.load_skill_settings()
	

func can_dash():
	var direction = Input.get_axis("move_left", "move_right")
	return Input.is_action_just_pressed("dash") and direction != 0 and not is_dashing and dash_timer <= 0 and skill_settings.has_dash

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += Global.gravity * delta

func _physics_process(delta):
	# TODO: play fall animation
	apply_gravity(delta)
	
	state_manager.update_state(delta)
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
	
	if dash_timer > 0:
		dash_timer -= delta
	
	move_and_slide()
