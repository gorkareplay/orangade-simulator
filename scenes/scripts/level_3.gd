extends Node2D

signal level_3_complete
var fired: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("left"):
		self.rotate(-0.015)
	if Input.is_action_pressed("right"):
		self.rotate(0.015)


func _on_body_entered(_body: Node2D) -> void:
	if fired == false: 
		emit_signal("level_3_complete")
		fired = true
