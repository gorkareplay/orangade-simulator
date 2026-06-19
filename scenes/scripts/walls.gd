extends Node2D

var left: bool = false
var right: bool = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("left") or left:
		self.rotate(-0.5 * delta)
	if Input.is_action_pressed("right") or right:
		self.rotate(0.5 * delta)

func _on_left_button_down() -> void:
	left = true

func _on_left_button_up() -> void:
	left = false

func _on_right_button_down() -> void:
	right = true

func _on_right_button_up() -> void:
	right = false
