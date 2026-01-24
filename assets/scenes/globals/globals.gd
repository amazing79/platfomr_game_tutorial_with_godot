extends Node2D

const TOTAL_COINS : int = 4
var coins:int = 0
var lives: int = 3
var winGame : bool = true
var result_scene: PackedScene = load("res://assets/scenes/GameScreens/result_game.tscn")

# Called when the node enters the scene tree for the first time.
func add_coins() -> void:
	coins += 1
	if coins == TOTAL_COINS:
		winGame = true
		end_game()

func remove_lives() -> void:
	lives -= 1
	if lives <= 0: 
		winGame = false
		end_game()

func end_game() -> void:
	get_tree().change_scene_to_packed(result_scene)
	
func inicialize() -> void:
	coins = 0
	lives = 3
