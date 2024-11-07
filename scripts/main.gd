extends Node

var start_menu = null
var stage_1 = null
var game_over_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_main_menu()

func start_main_menu():
	start_menu = load("res://scenes/start_menu.tscn").instantiate()
	add_child(start_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	start_menu.queue_free()
	stage_1 = load("res://scenes/stage_1.tscn").instantiate()
	add_child(stage_1)
	pass

func game_over():
	stage_1.queue_free()
	game_over_scene = load("res://scenes/game_over.tscn").instantiate()
	add_child(game_over_scene)
	
	
