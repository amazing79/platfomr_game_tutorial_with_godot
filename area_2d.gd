extends Area2D

var is_open : bool = false
var is_on_door : bool = false
@export var target : Area2D
@export var player : CharacterBody2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up") and is_on_door:
		if is_open:
			$AnimatedSprite2D.play("open")
			$TeleportSound.play()
			player.visible = false
			$TeleportTimer.start()
		else: 
			$NearDoor/DoorLokedSound.play()


func _on_body_entered(body: Node2D) -> void:
	if Globals.hasKey and body.name == "Steve": # Replace with function body.
		self.is_open = true
	is_on_door = true
		


func _on_near_door_body_entered(body: Node2D) -> void:
	if Globals.hasKey and body.name == "Steve":
		$AnimatedSprite2D.play("closed") # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Steve":
		self.is_on_door = false # Replace with function body.
		if Globals.hasKey:
			$AnimatedSprite2D.play("closed")

func teleport() -> void:
	player.position = target.position


func _on_teleport_timer_timeout() -> void:
	teleport() # Replace with function body.
	player.visible = true
	target.get_node("AnimatedSprite2D").play("open")
