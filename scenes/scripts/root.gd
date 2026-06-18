extends Node2D

var title_screen = preload("res://scenes/tscn/title_screen.tscn").instantiate() as Control
var play_button = title_screen.get_node("PlayButton") as Button

var ingredients = preload("res://scenes/tscn/ingredients.tscn").instantiate() as Control
var mint = ingredients.find_child("Mint")
var water = ingredients.find_child("Water")
var sugar = ingredients.find_child("Sugar")
var lemon = ingredients.find_child("Lemon")
var lemonade = ingredients.find_child("Lemonade") as TextureRect

var level_1 = preload("res://scenes/tscn/levels/level_1.tscn").instantiate()
var line_edit = level_1.get_node("LineEdit") as LineEdit
var level_2 = preload("res://scenes/tscn/levels/level_2.tscn").instantiate() as Control
var level_3 = preload("res://scenes/tscn/levels/level_3.tscn").instantiate()
var level_4 = preload("res://scenes/tscn/levels/level_4.tscn").instantiate()

@onready var label = $Aptyp
@onready var flash = $Flash
@onready var audio_player = $AudioPlayer
@onready var music_player = $MusicPlayer
@onready var title = $Title

var waves = preload("res://assets/sounds/waves.wav")
var main_theme = preload("res://assets/sounds/main_theme.wav")
var ending_part = preload("res://assets/sounds/ending_part.wav")

var saved_positon: float = 0.0
var time: float = 0.0

func _ready() -> void:
	title_screen.position = Vector2.ZERO
	add_child(title_screen)
	add_child(ingredients)
	
	play_button.pressed.connect(_on_play_pressed)
	music_player.stream = waves
	music_player.play()
	
	$Title.pivot_offset = Vector2($Title.size.x / 2, $Title.size.y / 2)
	
func _process(delta: float) -> void:
	if title:
		time += delta
		$Title.rotation = sin(time * 2.0) * 0.02
	
func aptyp(line: String, delay: float = 0.1, timeA: float = 1.0) -> void:
	label.visible_characters = 0
	label.text = line
	
	for i in range(len(line)):
		label.visible_characters = i + 1
		audio_player.pitch_scale = randf_range(0.90, 1.10)
		audio_player.play()
		await get_tree().create_timer(delay).timeout
	await get_tree().create_timer(timeA).timeout
	
func orbit_to_point(node: Control, final_position: Vector2, duration: float = 1.0, loops: float = 2.0) -> void:
	var offset = node.position - final_position
	var orbit_func = func(t: float):
		node.position = final_position + offset.rotated(loops * TAU * t) * (1.0 - t)
	
	create_tween().tween_method(orbit_func, 0.0, 1.0, duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	
func stop_and_save():
	saved_positon = music_player.get_playback_position()
	music_player.stop()
	
func _on_play_pressed():
	play_button.queue_free()
	title.queue_free()
	
	music_player.stop()
	music_player.stream = main_theme
	music_player.play()
	
	await aptyp("hey")
	await aptyp("what the hell are you doing in my game?", 0.05, 2.0)
	await aptyp("you want lemonade to cool down from the excruciating heat?...", 0.05, 2.0)
	await aptyp("okay", 0.05, 0.5)
	await aptyp("in order to get your lemonade, you need to solve 4 puzzles made by me, the great Артур", 0.05, 2.0)
	await aptyp("in this puzzle you need to guess the code", 0.05, 2.0)
	await aptyp("the code is 1234, but since you're EMPTY headed there is NOTHING you can do", 0.1, 1.0)
	
	add_child(level_1)
	line_edit.level_1_complete.connect(_on_level_1_complete)
	

func _on_level_1_complete():
	level_1.queue_free()
	stop_and_save()
	await aptyp("how the hell did you do that", 0.05, 1.0)
	await aptyp("doesn't matter, here is one of the ingredients", 0.05)
	
	var tween = create_tween()
	tween.tween_property(mint, "position", Vector2(1792.0, 952.0), 4.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(5.0).timeout
	
	music_player.play(saved_positon)
	
	await aptyp("okay next puzzle", 0.05, 0.5)
	await aptyp("this is a game of battleships, I hope you know the rules", 0.05, 1.0)
	await aptyp("you are trying to guess the positions of my ships and vise-versa", 0.05, 1.0)
	await aptyp("you can just click to shoot my ships", 0.05, 1.0)
	await aptyp("you NEED to follow the TURN ORDER", 0.05, 1.0)
	level_2.position = Vector2(415, 70)
	add_child(level_2)
	
	level_2.level_2_complete.connect(_on_level_2_complete)
	level_2.second_ship_down.connect(_on_second_ship_down)
	
func _on_second_ship_down():
	await aptyp("hey what are you doing, you can't do that", 0.05)
	
func _on_level_2_complete():
	level_2.queue_free()
	stop_and_save()
	await aptyp("dude", 0.01, 0.7)
	await aptyp("okay you certanly cheated there", 0.05, 1.0)
	await aptyp("fine take the ingredient i don't care", 0.05, 2.0)
	
	var tween = create_tween()
	tween.tween_property(water, "position", Vector2(1664.0, 952.0), 3.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(4.0).timeout
	
	music_player.play(saved_positon)
	
	await aptyp("let's go next puzzle", 0.05, 1.0)
	await aptyp("so this is an impossible labyrinth i made that you need to complete", 0.05, 3.0)
	add_child(level_3)
	level_3.level_3_complete.connect(_on_level_3_complete)
	await aptyp("sadly i was not able to finish it so just IGNORE the eraser shavings", 0.05)

func _on_level_3_complete():
	print("complete")
	level_3.queue_free()
	stop_and_save()
	await aptyp("BRUH HOW ARE YOU DOING THIS STOP IT ALREADY!!!", 0.01, 1.0)
	await aptyp("good job, i guess", 0.1, 2.0)
	await aptyp("there you go", 0.075, 1.0)
	
	var tween = create_tween()
	tween.tween_property(sugar, "position", Vector2(1536.0, 952.0), 4.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(5.0).timeout
	
	music_player.play(saved_positon)
	await aptyp("and so, the final puzzle awaits", 0.05, 2.0)
	await aptyp("are you ready?", 0.2, 1.0)
	add_child(level_4)
	
	level_4.level_4_complete.connect(_on_level_4_complete)
	await aptyp("in this puzzle, you need to sort the fruits by color", 0.05, 2.0)
	await aptyp("sort them by color, and ignore the NUMBER OF LEAVES", 0.05)
	
func _on_level_4_complete():
	level_4.queue_free()
	await aptyp("NOOOOOOOOOOOOOOOOOO", 0.05)
	await aptyp("")
	
	ingredients.visible = true
	
	var tween = create_tween()
	tween.tween_property(lemon, "position", Vector2(1408.0, 952.0), 4.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(5.0).timeout
	
	orbit_to_point(mint, Vector2(960.0, 540.0), 10.0, 10.0)
	orbit_to_point(water, Vector2(960.0, 540.0), 10.0, 10.0)
	orbit_to_point(sugar, Vector2(960.0, 540.0), 10.0, 10.0)
	orbit_to_point(lemon, Vector2(960.0, 540.0), 10.0, 10.0)
	
	for i in range(100):
		flash.color.a += 0.01
		await get_tree().create_timer(0.1).timeout

	mint.visible = false
	water.visible = false
	sugar.visible = false
	lemon.visible = false
	
	flash.color.a = 0.0
	lemonade.visible = true
