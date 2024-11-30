extends Area2D

var touching = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and touching == 1:
		print("Interact")


func _on_body_entered(body: Node2D) -> void:
	animated_sprite_2d.play("fade_in")
	touching = 1
	

func _on_body_exited(body: Node2D) -> void:
	animated_sprite_2d.play("fade_out")
	touching = 0
