extends CharacterBody2D

class_name Enemy

var player_chase = false
var is_attacking = false
var player_in_attack_area = false
var player = null

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area = $AttackArea/CollisionShape2D

@export var speed = 100
@export var health = 100
@export var damage = 0

func _physics_process(delta: float) -> void:
	if health == 0:
		animated_sprite.play("death")
		await animated_sprite.animation_finished
		queue_free()
	
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

#TODO: Fix attack area reenter damage multiplication
func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		player_in_attack_area = true
		while player_in_attack_area:
			is_attacking = true
			animated_sprite.play("attack_1")
			
			await animated_sprite.animation_finished
			
			if player_in_attack_area:
				player.health = max(0, player.health - damage)
				print("Player health: " + str(player.health))
			
			is_attacking = false
		animated_sprite.play("idle")

func _on_attack_area_area_exited(area: Area2D) -> void:
	player_in_attack_area = false
