extends StaticBody2D

signal button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("normal") # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Steve":
		$ClickSound.play()
		$AnimatedSprite2D.play("pressed")
		button_pressed.emit()
		$Area2D.set_deferred("monitoring",false)
