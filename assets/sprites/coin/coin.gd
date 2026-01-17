extends Area2D

func _ready() -> void:
	$Animation.play("spin")
	

func _on_body_entered(_body: Node2D) -> void:
	$AnimationPlayer.play("bounce")

	
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free() # Replace with function body.
