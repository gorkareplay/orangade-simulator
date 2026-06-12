class_name Drag

signal drag_completed(data:Drag)

var source: Control = null
var destination: Control = null

var item: TextureRect
var preview: Control

func _init(_source: Control, _item: TextureRect, _preview: Control):
	self.source = _source
	self.item = _item
	self.preview = _preview
	self.preview.tree_exiting.connect(_on_tree_exiting)

func _on_tree_exiting()-> void:
	drag_completed.emit(self)
