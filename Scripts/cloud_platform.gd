extends "res://Scripts/platform.gd"

func response():
		emit_signal("delete_object", self)
