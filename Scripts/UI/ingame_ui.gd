extends CanvasLayer

@onready var dash_icon = $PanelContainer/GridContainer/DashIcon
@onready var double_jump_icon = $PanelContainer/GridContainer/DoubleJumpIcon
@onready var wall_jump_icon = $PanelContainer/GridContainer/WallJumpIcon
@onready var health_bar = $PanelContainer/Control/HealthBar

var skill_settings = {}
var player = null

func _ready() -> void:
	skill_settings = ConfigFileHandler.load_skill_settings()
	player = Global.get_player()

func _process(delta: float) -> void:
	dash_icon.visible = skill_settings.has_dash
	double_jump_icon.visible = skill_settings.has_double_jump
	wall_jump_icon.visible = skill_settings.has_wall_jump
	
	dash_icon.modulate.a = 1.0 if player.dash_timer <= 0 else 0.4
	double_jump_icon.modulate.a = 1.0 if player.double_jump_timer <= 0 else 0.4
	wall_jump_icon.modulate.a = 1.0 if player.wall_jump_timer <= 0 else 0.4
	
	health_bar.value = player.health
