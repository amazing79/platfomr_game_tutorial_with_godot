extends Node2D

const TOTAL_COINS : int = 4
var coins = 0
var lives = 3

# Called when the node enters the scene tree for the first time.
func add_coins() -> void:
	coins += 1
	if coins == TOTAL_COINS:
		restart_game()

func remove_lives() -> void:
	lives -= 1
	if lives <= 0: 
		restart_game()

func restart_game() -> void:
	coins = 0
	lives = 3
	get_tree().change_scene_to_file("res://assets/scenes/GameScreens/main_screen.tscn")
