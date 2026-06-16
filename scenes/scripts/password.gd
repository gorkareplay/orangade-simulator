extends LineEdit

signal level_1_complete

func _on_text_submitted(new_text):
	if new_text == "":
		emit_signal("level_1_complete")
