extends CharacterBody2D

class_name TheCreature

const SPEED = 150
var Chasing: bool = false
var Patrol: bool = false
var direction = -1


@onready var player: CharacterBody2D = %Player
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var ray: RayCast2D = $Ray
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sight: CollisionShape2D = $SeeingRange/Sight
@onready var seeing_range: Area2D = $SeeingRange



func _process(delta: float) -> void:
	# Controls the gravity
	if !is_on_floor():
		velocity += get_gravity() * delta
	
	# Changes the direction of the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = true
		if seeing_range.scale.x > 0:
			seeing_range.scale.x *= -1
			ray.scale.x *= -1

	elif direction < 0:
		animated_sprite_2d.flip_h = false
		if seeing_range.scale.x < 0:
			seeing_range.scale.x *= -1
			ray.scale.x *= -1
	
	
	# Controls Movement
	if Patrol == true:
		animated_sprite_2d.play("Patrol")
		if ray.is_colliding():
			direction *= -1
		position.x += direction * SPEED * 0.5 * delta
	elif Chasing == true:
		position.x += direction * SPEED * 2 * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()



func _on_seeing_range_body_entered(body: Node2D) -> void:
	Patrol = false
	Chasing = true
	print("I see you")


func _on_seeing_range_body_exited(body: Node2D) -> void:
	Patrol = true
	Chasing = false
	print("Must have been the wind")


func _on_ears_area_entered(area: Area2D) -> void:
	if global_position.x < player.global_position.x:
		direction = 1
	else:
		direction = -1
	Patrol = false
	Chasing = true


func _on_ears_area_exited(area: Area2D) -> void:
	Patrol = true
	Chasing = false
