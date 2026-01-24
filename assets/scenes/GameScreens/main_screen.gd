extends Control


func _on_button_pressed() -> void:
	Globals.inicialize()
	get_tree().change_scene_to_file("res://assets/scenes/maps/level_1.tscn")
