extends Control

func add_item_at(item: TextureRect, at_position: Vector2) -> void:
	for child in find_children("Tile*", "TextureRect"):
		if child.get_global_rect().has_point(at_position):
			item.global_position = child.global_position + item.size / 2
			return

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
	return intersects_tile(at_position)

func _drop_data(at_position:Vector2, data:Variant)-> void:
	if !data is Drag: return
	var drag_data := data as Drag

	drag_data.destination = self
	add_item_at(drag_data.item, at_position)
	drag_data.item.show()
func _on_drag_completed(data: Drag) -> void:
	data.item.show()
