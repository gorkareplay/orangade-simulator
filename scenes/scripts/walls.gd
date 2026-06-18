extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_pressed("left"):
		self.rotate(-0.015)
	if Input.is_action_pressed("right"):
		self.rotate(0.015)
