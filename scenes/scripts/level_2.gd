extends Control

var tile_path = preload("res://scenes/tscn/tile.tscn")
var scoring_tiles: Array = [6, 7, 11, 12, 33, 34, 36, 39, 53, 54, 55, 56, 70, 71, 72, 75, 76, 85, 86, 91, 93, 95, 96]

var tile_tick = preload("res://assets/Level 2/tile_tick.png")
var tile_cross = preload("res://assets/Level 2/tile_cross.png")

var tile_size = Vector2(64, 64)
var origin_point = Vector2(100, 100)
var cols: int = 10

var score: int = 0

func _ready() -> void:
	
	var spacing = tile_size / 2
	
	for i in range(100):
		var tile = tile_path.instantiate() as Sprite2D
		var button = tile.get_node("Button") as Button
		
		tile.position = origin_point + Vector2(i % cols, i / cols) * (tile_size + spacing)
		button.pressed.connect(_button_pressed.bind(i, button))
		add_child(tile)
	
func _process(_delta: float) -> void:
	if score == 20:
		emit_signal("level_2_complete")

func _button_pressed(index: int, button: Button) -> void:
	button.disabled = true
	var tile = get_child(index) as Sprite2D
	
	if index in scoring_tiles:
		tile.texture = tile_tick
		score += 1
	else:
		tile.texture = tile_cross
