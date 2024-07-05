extends CharacterBody2D
class_name Player

@export var GRAVITY = 4
@export var MAX_SPEED = 50
@export var JUMP_SPEED = -130
@export var JUMP_RELEASE_FORCE = -70
@export var ACCELERATION = 10
@export var FRICTION = 10
@export var FALL_GRAVITY = 4

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	apply_gravity()
	var input_strength = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if input_strength!=0:
		apply_acceleration(input_strength)
		sprite.play("run")
	else:
		apply_friction()
		sprite.play("idle")
		
	if is_on_floor():
		if Input.is_action_pressed("up"):
			velocity.y = JUMP_SPEED
	else:
		sprite.play("jump")
		if Input.is_action_just_released("up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY
			
	var was_in_air = not is_on_floor()
	move_and_slide()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		sprite.play("run")
		sprite.frame = 1
	
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
