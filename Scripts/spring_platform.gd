extends "res://Scripts/platform.gd"

func response():
	$spring_tile.play("default")

func _on_spring_tile_animation_finished():
	$spring_tile.frame = 0
	$spring_tile.stop()
