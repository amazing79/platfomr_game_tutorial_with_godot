extends Node2D

var coins = 0
var lives = 3

# Called when the node enters the scene tree for the first time.
func add_coins() -> void:
	coins += 1


func remove_lives() -> void:
	if lives > 0:
		lives -= 1
