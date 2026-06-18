extends LineEdit

signal level_1_complete
var fired: bool = false

func _on_text_submitted(new_text):
	if new_text == "" and fired == false:
		emit_signal("level_1_complete")
		fired = true
