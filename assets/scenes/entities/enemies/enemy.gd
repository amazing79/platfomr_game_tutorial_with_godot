extends CharacterBody2D

@export_category("Configuration")
@export var direction = -1
@export var detect_cliffs = true
const SPEED = 300.0
var walk_speed = 50

func _ready() -> void:
	$EnemySprite.play("walking")
	$Floor_checker.enabled = detect_cliffs
	$Floor_checker.position.x = $CollisionShape2D.shape.get_size().x * direction
	
	if direction != -1:
		$EnemySprite.flip_h = true
	if not detect_cliffs:
		modulate = Color(0.859, 0.235, 0.847, 1.0)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif detect_cliffs and not $Floor_checker.is_colliding():
		direction *= -1
		$EnemySprite.flip_h = not $EnemySprite.flip_h
		$Floor_checker.position.x = $CollisionShape2D.shape.get_size().x * direction
		
	velocity.x = walk_speed * direction

	move_and_slide()


func _on_top_checker_body_entered(body: Node2D) -> void:
	$SquashSound.play()
	$EnemySprite.play("squashed") 
	$Remove_timer.start()
	$Hurt_checker.set_collision_mask_value(1, false)
	#body for now is Steve
	walk_speed = 0
	body.rebound()

func _on_remove_timer_timeout() -> void:
	call_deferred("queue_free")


func _on_hurt_checker_body_entered(body: Node2D) -> void:
	body.take_damege(position.x) # Replace with function body.
