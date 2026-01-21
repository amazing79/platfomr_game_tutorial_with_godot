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

const PUSH_FORCE : float = 250.0
var actual: State = State.IDLE
var flip = false
var color_original: Color
var speed_original: float = speed

func _ready() -> void:
	color_original = self.modulate


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
			

func _on_fall_zone_body_entered(_body: Node2D) -> void:
	Globals.coins = 0
	Globals.remove_lives()
	reset_scene()
	

func reset_scene() -> void:
	get_tree().reload_current_scene()
	
func rebound() -> void:
	velocity.y = jump_velocity * 0.75
	
func take_damege(enemy_position : float) -> void:
	$Timer.start()
	speed = 0
	velocity.y = jump_velocity * .5
	modulate = Color(0.796, 0.0, 0.0, 0.525)
	if position.x <= enemy_position:
		#esta a la izquierda
		velocity.x -= PUSH_FORCE
	else:
		#Esta a la derecha	
		velocity.x += PUSH_FORCE
	set_collision_layer_value(1,false)
	set_collision_mask_value(5, false)
	Input.action_release("left")
	Input.action_release("right")
	Globals.remove_lives()


func _on_timer_timeout() -> void:
	set_collision_layer_value(1 , true)
	set_collision_mask_value(5, true)
	self.modulate = color_original
	speed = speed_original
