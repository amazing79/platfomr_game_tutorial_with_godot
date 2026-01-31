extends CharacterBody2D

enum State {
	IDLE,
	RUN,
	JUMP,
	CLIMB,
	DUCK,
	DEAD,
	WALL
}

@export_category("Player Stats")
@export var speed : float = 450.0
@export var jump_velocity : float = -650.0

const fireball = preload("res://assets/scenes/entities/fireball/fireball.tscn")
const PUSH_FORCE : float = 250.0
const ACCELARATION : float = 1.5
var actual: State = State.IDLE
var flip = false
var color_original: Color
var speed_original: float = speed
var accelerate = false
var on_ladder: bool = false

func _ready() -> void:
	color_original = self.modulate


func _physics_process(delta: float) -> void:
	# Add the gravity.
	$WallChecker.rotation_degrees = 180 if  self.get_actual_direction() == -1 else 0
	if actual == State.DEAD:
		return
	accelerate = false
	if not is_on_floor() and not on_ladder:
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
		$JumpSound.play()
	elif Input.is_action_just_pressed("jump") and $WallChecker.is_colliding():
		flip = not flip
		velocity.y = jump_velocity * 0.7
		$JumpSound.play()
	
	if $WallChecker.is_colliding():
		actual = State.WALL
	
	if on_ladder: 
		actual = State.CLIMB
	
	if Input.is_action_just_pressed("fire") and not on_ladder:
		shot_fireball()
	
	if Input.is_action_pressed("run"):
		accelerate = true
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	var ascending := Input.get_axis("up", "down")
	
	if direction:
		if accelerate:
			velocity.x = direction * (speed * ACCELARATION)
			$sprite.set_speed_scale(2.0)
		else: 
			velocity.x = direction * speed
			$sprite.set_speed_scale(1)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if ascending and on_ladder:
		velocity.y = ascending * speed
	elif on_ladder:
		velocity.y = move_toward(velocity.y, 0, speed)
		$sprite.stop()
	
	play_actual_state(actual)
	$sprite.flip_h = flip
	move_and_slide()
	

func play_actual_state(new:State) -> void:
	match new:
		State.IDLE:
			$sprite.play("idle")
		State.RUN:
			$sprite.play("walk") 
		State.JUMP:
			$sprite.play("jump")
		State.DUCK:
			$sprite.play("duck")
		State.WALL:
			$sprite.play("wall")
		State.CLIMB:
			$sprite.play("climbing")
			

func get_actual_direction() -> int:
	return -1 if $sprite.flip_h else 1

func _on_fall_zone_body_entered(_body: Node2D) -> void:
	Globals.coins = 0
	Globals.remove_lives()
	if Globals.lives > 0:
		reset_scene()
	

func reset_scene() -> void:
	get_tree().reload_current_scene()
	
func rebound() -> void:
	velocity.y = jump_velocity * 0.75
	
func take_damege(enemy_position : float) -> void:
	$HurtSound.play()
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
	if Globals.lives == 0:
		actual = State.DEAD


func _on_timer_timeout() -> void:
	set_collision_layer_value(1 , true)
	set_collision_mask_value(5, true)
	self.modulate = color_original
	speed = speed_original

func shot_fireball() -> void:
	var ball = fireball.instantiate()
	var dir = self.get_actual_direction()
	ball.direction = dir
	ball.position.x = self.position.x + ( 25 * dir)
	ball.position.y = self.position.y + 25
	get_parent().add_child(ball)
	#self.add_child(ball)


func _on_ladder_checker_body_entered(_body: Node2D) -> void:
	on_ladder = true
	set_collision_mask_value(2, false)


func _on_ladder_checker_body_exited(_body: Node2D) -> void:
	on_ladder = false 
	set_collision_mask_value(2, true)
