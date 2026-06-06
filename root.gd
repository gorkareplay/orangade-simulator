extends Node2D

var fruit_scene = preload("res://fruits.tscn")


func _on_timer_timeout() -> void:
	var fruit = fruit_scene.instantiate() as RigidBody2D
	var positions = $Positions.get_children().pick_random() as Node2D
	
	fruit.position = positions.position
	add_child(fruit)
