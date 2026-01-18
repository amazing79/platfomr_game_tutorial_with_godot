extends CharacterBody2D

@export_category("Configuration")
@export var direction = -1
@export var detect_cliffs = true
const SPEED = 300.0
const WALK_SPEED = 50

func _ready() -> void:
	$EnemySprite.play("walking")
	$Floor_checker.enabled = detect_cliffs
	$Floor_checker.position.x = $CollisionShape2D.shape.get_size().x * direction
	
	if direction != -1:
		$EnemySprite.flip_h = true
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif detect_cliffs and not $Floor_checker.is_colliding():
		direction *= -1
		$EnemySprite.flip_h = not $EnemySprite.flip_h
		$Floor_checker.position.x = $CollisionShape2D.shape.get_size().x * direction
		
	velocity.x = WALK_SPEED * direction

	move_and_slide()
