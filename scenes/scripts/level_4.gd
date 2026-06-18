extends Control

signal level_4_complete
var configuration: Dictionary = { &"Tile 1": &"Lemon 4", &"Tile 2": &"Lemon 5", &"Tile 3": &"Lemon 3", &"Tile 4": &"Lemon 2", &"Tile 5": &"Lemon 1", &"Tile extra": null }
var fired: bool = false

func add_item_at(item: TextureRect, at_position: Vector2) -> void:
	for child in find_children("Tile*", "TextureRect"):
		if child.get_global_rect().has_point(at_position):
			item.global_position = child.global_position
			return

func tile_at(at_position: Vector2) -> TextureRect:
	for child in find_children("Tile*", "TextureRect"):
		if child.get_global_rect().has_point(at_position):
			return child
	return null

func item_at(at_position: Vector2) -> TextureRect:
	for child in find_children("Lemon*", "TextureRect"):
		if child.get_global_rect().has_point(at_position):
			return child
	return null

func intersects_tile(at_position: Vector2) -> bool:
	for child in find_children("Tile*", "TextureRect"):
		if child.get_global_rect().has_point(at_position):
			return true
	return false
func _get_drag_data(at_position:Vector2)-> Variant:
	var item := item_at(at_position)
	if item == null: return null

	var preview := item.duplicate() as Control
	var wrapper := Control.new()
	wrapper.add_child(preview)
	preview.position = -item.size / 2
	var drag_data = Drag.new(self, item, wrapper)
	set_drag_preview(drag_data.preview)
	item.hide()
	drag_data.drag_completed.connect(_on_drag_completed)
	return drag_data

func _can_drop_data(at_position:Vector2, data:Variant)-> bool:
	if !data is Drag: return false
	if configuration[tile_at(at_position).name] != null: return false
	return intersects_tile(at_position)

func _drop_data(at_position:Vector2, data:Variant)-> void:
	if !data is Drag: return
	var drag_data := data as Drag
	drag_data.destination = self
	for key in configuration:
		if configuration[key] == (drag_data.item.name):
			configuration[key] = null
	if tile_at(at_position):
		configuration[tile_at(at_position).name] = drag_data.item.name
	add_item_at(drag_data.item, at_position)
	drag_data.item.show()

func _on_drag_completed(data: Drag) -> void:
	data.item.show()
	if fired == false:
		if configuration == { &"Tile 1": &"Lemon 1", &"Tile 2": &"Lemon 2", &"Tile 3": &"Lemon 3", &"Tile 4": &"Lemon 4", &"Tile 5": &"Lemon 5", &"Tile extra": null } or configuration == { &"Tile 1": &"Lemon 5", &"Tile 2": &"Lemon 4", &"Tile 3": &"Lemon 3", &"Tile 4": &"Lemon 2", &"Tile 5": &"Lemon 1", &"Tile extra": null }:
			emit_signal("level_4_complete")
			fired = true
