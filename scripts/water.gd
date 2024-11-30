extends Area2D

@onready var player: CharacterBody2D = %Player


func _on_body_entered(body: Node2D) -> void:
	player.swimming = true



func _on_body_exited(body: Node2D) -> void:
	player.swimming = false
