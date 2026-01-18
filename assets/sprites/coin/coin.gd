extends Area2D
#Custom signal
signal coin_collected

func _ready() -> void:
	$Animation.play("spin")
	

func _on_body_entered(_body: Node2D) -> void:
	$AnimationPlayer.play("bounce")
	Globals.add_coins()
	emit_signal("coin_collected")
	#evita doble colision y contar recolectar la moneda 2 vecesd 
	set_collision_mask_value(1, false)
	
	

	
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free() # Replace with function body.
