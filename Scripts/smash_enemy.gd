extends Node2D
class_name SmashEnemy

enum { HOVER, FALL, LAND, RISE }

const SPEED = 250
const UP_SPEED = 50

@onready var start_pos = global_position
var state = HOVER
@onready var Raycast = $CheckGroundCast
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	match state:
		HOVER: hover_state()
		FALL: fall_state(delta)
		LAND: land_state() 
		RISE: rise_state(delta) 
		
func hover_state():
	state = FALL 

func fall_state(delta):
	sprite.play("down")
	position.y += SPEED * delta
	if Raycast.is_colliding():
		var collision_point = Raycast.get_collision_point()
		position.y = collision_point.y - 8
		state = LAND

func land_state():
	await get_tree().create_timer(1).timeout
	state = RISE

func rise_state(delta):
	sprite.play('up')
	position.y = move_toward(position.y, start_pos.y, UP_SPEED*delta)
	if position.y == start_pos.y:
		state = HOVER
