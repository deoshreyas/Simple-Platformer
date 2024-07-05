extends CharacterBody2D
class_name Player

const GRAVITY = 4.0
const SPEED = 50.0
const JUMP_SPEED = -130.0

func _physics_process(_delta):
	apply_gravity()
	var input_strength = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if input_strength!=0:
		apply_acceleration(input_strength)
	else:
		apply_friction()
		
	if is_on_floor():
		if Input.is_action_just_pressed("up"):
			velocity.y = JUMP_SPEED
	else:
		if Input.is_action_just_released("up") and velocity.y < JUMP_SPEED/2:
			velocity.y = JUMP_SPEED/2
		if velocity.y > 0:
			velocity.y += GRAVITY
			
	move_and_slide()
	
func apply_gravity():
	velocity.y += GRAVITY

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 10)
		
func apply_acceleration(strength):
	velocity.x = move_toward(velocity.x, strength * SPEED, 10)
