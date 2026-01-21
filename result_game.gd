extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var text :String = "Congratulations! you win the game!"
	if not Globals.winGame:
		text = "Oh no, you lose! you are pathetic!"
		$LosseIcon.visible = true
		$WinIcon.visible = false
	$Label.text = text
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/GameScreens/main_screen.tscn")
