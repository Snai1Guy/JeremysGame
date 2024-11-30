extends Area2D

@onready var respawnpoint: Marker2D = $Respawnpoint

func _on_body_entered(body: Node2D) -> void:
	Manager.update_spawn(respawnpoint.global_position,1)
