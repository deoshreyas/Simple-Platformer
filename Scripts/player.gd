extends CharacterBody2D
class_name Player

enum { MOVE, CLIMB }

var state = MOVE

@export var GRAVITY = 4
@export var MAX_SPEED = 50
@export var JUMP_SPEED = -130
@export var JUMP_RELEASE_FORCE = -70
@export var ACCELERATION = 10
@export var FRICTION = 10
@export var FALL_GRAVITY = 4
@export var CLIMB_SPEED = 50
@export var DOUBLE_JUMPS = 1

@onready var sprite: = $AnimatedSprite2D
@onready var ladderCheck: = $LadderCheckRaycast
@onready var jump_buffer_timer: = $JumpBuffer
@onready var coyote_jump_timer: = $CoyoteTimer

var double_jump = DOUBLE_JUMPS
var buffered_jump = false
var coyote_jump : bool

func _physics_process(_delta):
	var input_axis_x = Input.get_axis("left", "right")
	var input_axis_y = Input.get_axis("up", "down")
	match state:
		MOVE: move_state(input_axis_x)
		CLIMB: climb_state(input_axis_y)

func move_state(input_axis):
	if is_on_ladder() and Input.is_action_pressed("up"):
		state = CLIMB
	apply_gravity()
	if input_axis!=0:
		apply_acceleration(input_axis)
		sprite.play("run")
	else:
		apply_friction()
		sprite.play("idle")
		
	if is_on_floor() or coyote_jump:
		double_jump = DOUBLE_JUMPS
		if Input.is_action_just_pressed("up") or buffered_jump:
			velocity.y = JUMP_SPEED
			buffered_jump = false
	else:
		sprite.play("jump")
		if Input.is_action_just_released("up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if Input.is_action_just_pressed("up") and double_jump>0:
			velocity.y = JUMP_SPEED
			double_jump -= 1
		if Input.is_action_just_pressed("up"):
			buffered_jump = true 
			jump_buffer_timer.start()
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY
			
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		sprite.play("run")
		sprite.frame = 1
	var just_left_ground = not is_on_floor() and was_on_floor
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true 
		coyote_jump_timer.start()

func climb_state(input_axis):
	if not is_on_ladder():
		state = MOVE
	if input_axis!=0:
		sprite.play("run")
	else:
		sprite.play("idle")
	velocity.y = input_axis * CLIMB_SPEED
	move_and_slide()

func is_on_ladder():
	if not ladderCheck.is_colliding(): return false 
	if ladderCheck.get_collider() is Ladder: return true 
	return false
	
func apply_gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 300)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
		
func apply_acceleration(strength):
	if strength>0:
		sprite.flip_h = true 
	else:
		sprite.flip_h = false
	velocity.x = move_toward(velocity.x, strength * MAX_SPEED, ACCELERATION)

func _on_jump_buffer_timeout():
	buffered_jump = false

func _on_coyote_timer_timeout():
	coyote_jump = false
