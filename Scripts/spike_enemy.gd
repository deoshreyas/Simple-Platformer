@tool 
extends Path2D
class_name SpikeEnemy

enum ANIMATION_TYPE { LOOP, BOUNCE }

@export var AnimationType = ANIMATION_TYPE: set = _set_state, get = _get_state
@export var speed = 1: set = _set_speed, get = _get_speed

func _set_state(value):
	AnimationType = value
	var ap = $AnimationPlayer
	if ap:
		play_updated_anim(ap)
		
func _get_state():
	return AnimationType
	
func _get_speed():
	return speed
	
func _set_speed(value):
	speed = value 
	var ap: = $AnimationPlayer
	if ap:
		ap.set_speed(speed)

@onready var sprite = $AnimationPlayer

func _ready():
	play_updated_anim(sprite)

func play_updated_anim(animation_player):
	match AnimationType:
		ANIMATION_TYPE.LOOP: animation_player.play("PathLoop")
		ANIMATION_TYPE.BOUNCE: animation_player.play("PathBounce")
