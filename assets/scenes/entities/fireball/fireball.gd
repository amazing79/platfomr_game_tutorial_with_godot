extends CharacterBody2D

const SPEED :float = 40.0
const REBOUND :float = -300.0
const GRAVITY : float = 20.0
var direction = 1

func _ready() -> void:
	$FireSound.play()

func _physics_process(_delta: float) -> void:
	if is_on_floor():
		velocity.y += REBOUND
	else:
		velocity.y += GRAVITY
	velocity.x +=  SPEED *  direction
	$Sprite2D.rotation_degrees += 25  * direction
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.
