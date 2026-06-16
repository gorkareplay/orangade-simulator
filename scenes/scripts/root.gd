extends Node2D

var title_screen = preload("res://scenes/tscn/title_screen.tscn").instantiate() as Control
var play_button = title_screen.get_node("PlayButton") as Button
var level_1 = preload("res://scenes/tscn/levels/level_1.tscn").instantiate()
var line_edit = level_1.get_node("LineEdit") as LineEdit
var level_2 = preload("res://scenes/tscn/levels/level_2.tscn").instantiate()
#var level_3 = preload("res://scenes/tscn/levels/level_3.tscn").instantiate()
var level_4 = preload("res://scenes/tscn/levels/level_4.tscn").instantiate()

func _ready() -> void:
	
	title_screen.position = Vector2.ZERO
	add_child(title_screen)
	
	play_button.pressed.connect(_on_play_pressed)

func _on_play_pressed():
	play_button.queue_free()
	add_child(level_1)
	
	line_edit.level_1_complete.connect(_on_level_1_complete)

func _on_level_1_complete():
	level_1.queue_free()
	add_child(level_2)
	
	level_2.level_2_complete.connect(_on_level_2_complete)

func _on_level_2_complete():
	level_2.queue_free()
#	add_child(level_3)

#	level_3.level_3_complete.connect(_on_level_3_complete)
	add_child(level_4)

func _on_level_3_complete():
#	level_3.queue_free()
	add_child(level_4)
	
	level_4.level_4_complete.connect(_on_level_4_complete)

func _on_level_4_complete():
	print("Плаке плаке")
