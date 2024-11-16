extends CharacterBody2D

class_name Enemy

var player_chase = false
var is_attacking = false
var player_in_attack_area = false
var player = null
var player_hitbox = null

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area = $AttackArea/CollisionShape2D

@export var speed = 100
@export var health = 100
@export var damage = 0

func _physics_process(delta: float) -> void:
	if health == 0:
		animated_sprite.play("death")
	
	if not is_on_floor():
		velocity.y += Global.gravity * delta
	
	if player_chase and player != null and not is_attacking:
		animated_sprite.play("run")
		
		var direction = (player.position - position).normalized() 
		position += direction * speed * delta
		
		if (player.position.x - position.x) < 0:
			animated_sprite.flip_h = false
			attack_area.position.x = -abs(attack_area.position.x)
		else:
			animated_sprite.flip_h = true
			attack_area.position.x = abs(attack_area.position.x);
	
	if not player_chase and not animated_sprite.animation_finished:
		animated_sprite.play("idle")
	
	move_and_slide()
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true
	print("Player detected by enemy")

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
	print("Player undetected by enemy")

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack_area") and player.attack_area.disabled == false:
		health = max(0, health - player.damage)
	
	#TODO: Add attack_2

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		player_hitbox = area
		player_in_attack_area = true
		is_attacking = true
		animated_sprite.play("attack_1")

func _on_attack_area_area_exited(area: Area2D) -> void:
	player_in_attack_area = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "death":
		queue_free()
	elif animated_sprite.animation == "attack_1":
		is_attacking = false
		animated_sprite.play("idle")
		
		if player_in_attack_area:
			player.inflict_damage(damage)
			_on_attack_area_area_entered(player_hitbox)
