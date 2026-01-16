extends CharacterBody2D

enum State {
	IDLE,
	RUN,
	JUMP,
	CLIMB,
	DUCK
}

@export_category("Player Stats")
@export var speed : float = 450.0
@export var jump_velocity : float = -600.0

var actual: State = State.IDLE
var flip = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		actual = State.JUMP

	if Input.is_action_pressed("left") and is_on_floor():
		actual = State.RUN
		flip = true
	elif Input.is_action_pressed("right") and is_on_floor():
		actual = State.RUN
		flip = false
	elif Input.is_action_pressed("down") and is_on_floor():
		actual = State.DUCK
	elif is_on_floor():
		actual = State.IDLE
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	set_state(actual)
	$sprite.flip_h = flip
	move_and_slide()
	
func set_state(new:State) -> void:
	match new:
		State.IDLE:
			$sprite.play("idle")
		State.RUN:
			$sprite.play("walk") 
		State.JUMP:
			$sprite.play("jump")
		State.DUCK:
			$sprite.play("duck")
			
			
		
	
