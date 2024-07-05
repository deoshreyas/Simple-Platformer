extends CharacterBody2D
class_name WalkingEnemy

@export var SPEED = 25
var direction = Vector2.RIGHT

@onready var ledgeCheckRaycast1 = $LedgeCheck1
@onready var ledgeCheckRaycast2 = $LedgeCheck2

func _physics_process(_delta):
	var foundLedge = not ledgeCheckRaycast1.is_colliding() or not ledgeCheckRaycast2.is_colliding()
	if is_on_wall() or foundLedge:
		direction *= -1
		
	$AnimatedSprite2D.flip_h = direction.x > 0
		
	velocity = SPEED * direction
	move_and_slide()
