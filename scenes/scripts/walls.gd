extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		self.rotate(-0.5 * delta)
	if Input.is_action_pressed("right"):
		self.rotate(0.5 * delta)
