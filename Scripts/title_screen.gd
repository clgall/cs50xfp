extends Control

@onready var highscore = $main/highscore as Label

func _ready():
	highscore.text = "Highscore\n" + str(Global.highscore)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_start_pressed():
	if get_tree().change_scene_to_file("res://Scenes/game.tscn") != OK:
		print("Error")
	


func _on_btn_exit_pressed():
	get_tree().quit()
