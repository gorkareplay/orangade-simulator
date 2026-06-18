extends Node2D

signal level_3_complete
var fired: bool = false
var wall_path = preload("res://scenes/tscn/walls.tscn").instantiate() as Node2D

func _ready() -> void:
	add_child(wall_path)

func _on_body_entered(_body: Node2D) -> void:
	if fired == false: 
		emit_signal("level_3_complete")
		fired = true
