extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Steve" :
		self.visible = false # Replace with function body.
		set_collision_mask_value(1, false)	
		Globals.take_key()
		$KeySound.play()


func _on_key_sound_finished() -> void:
	queue_free() # Replace with function body.
