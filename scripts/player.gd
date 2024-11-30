extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0

var swimming = false
var hidding = false

@onready var noise_range: Area2D = $NoiseRange
@onready var noise_level: CollisionShape2D = $NoiseRange/NoiseLevel
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Movement and Animations
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor() and !swimming and !hidding:
		velocity += get_gravity() * delta

	# Handle jump.
	if !swimming and !hidding:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Gets the input direction: -1,0,1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flips the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Plays the Animations, but first check if the character is not swimming or hidding
	if !swimming and !hidding:
		if is_on_floor():
			if direction == 0 and Input.is_action_pressed("crouch"):
				animated_sprite_2d.play("Crouched")
			elif direction != 0 and Input.is_action_pressed("crouch"):
				animated_sprite_2d.play("Crouch_Walking")
			elif direction != 0 and Input.is_action_pressed("run"):
				animated_sprite_2d.play("Running")
			elif direction != 0:
				animated_sprite_2d.play("Walking")
			else: 
				animated_sprite_2d.play("Idle")
				
		else:
			animated_sprite_2d.play("Jumping")
	# Animations for Swimming
	elif swimming:
		if direction != 0:
			animated_sprite_2d.play("Swimming")
		else:
			animated_sprite_2d.play("Floating")
	# Animation for Hidding
	else:
		animated_sprite_2d.play("Hidden")
		
	# Actually applies the movement and noise level
	if !swimming and !hidding:
		if direction:
			if Input.is_action_pressed("crouch"):
				velocity.x = direction * SPEED * 0.45
				noise_level.shape.radius = 100
			elif Input.is_action_pressed("run"):
				velocity.x = direction * SPEED
				noise_level.shape.radius = 300
			else:
				velocity.x = direction * SPEED * 0.75
				noise_level.shape.radius = 200
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			noise_level.shape.radius = 1
	# Movement for Swimming
	elif swimming:
		noise_level.shape.radius = 1
		if Input.is_action_pressed("jump"):
			velocity.y = SPEED * -1
		elif Input.is_action_pressed("crouch"):
			velocity.y = SPEED
		elif Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
			velocity.x = direction * SPEED
			velocity.y = 0
		else:
			velocity.x = 0
			velocity.y = 0
	# Movement for Hidding
	else:
		set_collision_layer_value(2,0)
		noise_range.set_collision_layer_value(3,0)
		velocity.x = 0
		velocity.y = 0
		await get_tree(). create_timer(0.2). timeout
		if Input.is_anything_pressed():
			hidding = false
			set_collision_layer_value(2,1)
			noise_range.set_collision_layer_value(3,1)
	
	
	
	
	move_and_slide()

func _ready() -> void:
	self.position = Manager.spawn_point
	
