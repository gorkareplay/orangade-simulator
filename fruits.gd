extends RigidBody2D

func _ready() -> void:
	var frame_count = 16
	var frame = floor(randf() * frame_count)
	$AnimatedSprite2D.frame = frame
