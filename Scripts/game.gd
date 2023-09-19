extends Node2D

#gets the platform container node for spawning randomly and the first platform`s height.
@onready var platform_container = $platform_container as Node2D
@onready var platform_init_pos_y = $platform_container/platform.position.y
#gets the camera so it actually moves
@onready var camera = $camera as Camera2D
#gets player so camera can follow them
@onready var player = $player as CharacterBody2D #change later for char select
#gets label for point demonstration
@onready var score_label = $camera/score as Label
@onready var camera_start_position = $camera.position.y
#gets all platforms in an array for instantiating
@export var platform_scene : Array[PackedScene] = []


var last_platform_spc = false
var score := 0

func level_generator(amount):
	
	for items in amount:
		
		var new_type = randi() % 4
		platform_init_pos_y -= randf_range(36,54) # this will make them keep going up
		
		if last_platform_spc or new_type == 0: #check so two special platforms cant appear twice in a row
			new_type = 0
			last_platform_spc = false
		else:
			if score < 1000:
				new_type = 2
			last_platform_spc = true
			
		var new_platform = platform_scene[new_type].instantiate() as StaticBody2D
		
		if new_type == 1 or new_type == 3:
				new_platform.delete_object.connect(delete_object)			
		
		
		if new_type != null:
			new_platform.position = Vector2(randf_range(20,160),platform_init_pos_y)
			platform_container.add_child(new_platform)
			
			
# Called when a platform is destroyed by the player (see cloud_platform)
func delete_object(obstacle):
	if obstacle.is_in_group("player"):
		#updates highscore
		if score > Global.highscore:
			Global.highscore = score
			
		if get_tree().change_scene_to_file("res://Scenes/title_screen.tscn") != OK:
			print("Error")
	elif obstacle.is_in_group("platform") or obstacle.is_in_group("enemies"):
		obstacle.queue_free()
		level_generator(1)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() #not using this makes the game use the same seed always for rand functionsx
	level_generator(20)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y
	score_update()

func _on_platform_cleaner_body_entered(body):
	delete_object(body)

func score_update():
	score = camera_start_position - camera.position.y
	score_label.text = str(int(score))
