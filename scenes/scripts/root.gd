extends Node2D

var title_screen = preload("res://scenes/tscn/title_screen.tscn").instantiate() as Control
var play_button = title_screen.get_node("PlayButton") as Button
var level_1 = preload("res://scenes/tscn/levels/level_1.tscn").instantiate()

func _ready() -> void:
	
	title_screen.position = Vector2.ZERO
	add_child(title_screen)
	
	play_button.pressed.connect(_on_play_pressed)

func _on_play_pressed():
	play_button.queue_free()
	add_child(level_1)
