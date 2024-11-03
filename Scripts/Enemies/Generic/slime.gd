extends Enemy

class_name Slime

@export var slime_speed = 100.0
@export var slime_health = 40
@export var slime_damage = 10

func _ready():
	speed = slime_speed
	health = slime_health
	damage = slime_damage
