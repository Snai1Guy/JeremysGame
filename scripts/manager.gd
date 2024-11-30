extends Node

@onready var player: CharacterBody2D = %Player


var spawn_point = Vector2(0,0)
var line = 0


func update_spawn(new_point,new_line):
	spawn_point = new_point
	line = new_line
	print(line)
