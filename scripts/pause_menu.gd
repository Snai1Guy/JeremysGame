extends Control

@onready var margin_container: MarginContainer = $MarginContainer

func _ready() -> void:
	margin_container.hide()

func resume():
	get_tree().paused = false
	margin_container.hide()

func pause():
	get_tree().paused = true
	margin_container.show()

func Esc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()


func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(delta: float) -> void:
	Esc()
