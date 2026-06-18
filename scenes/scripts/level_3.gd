extends Node2D

signal level_3_complete

var fired: bool = false
var wall_path = preload("res://scenes/tscn/walls.tscn").instantiate() as Node2D

func _ready() -> void:
	add_child(wall_path)
	get_child(1).get_child(0).get_child(2).body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D):
	if fired == false: 
		emit_signal("level_3_complete")
		print("complete")
		fired = true
