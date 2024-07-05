extends Path2D
class_name SpikeEnemy

enum ANIMATION_TYPE { LOOP, BOUNCE }

@onready var sprite = $AnimationPlayer

@export var AnimationType : ANIMATION_TYPE
@export var speed : float = 1.0

func _ready():
	play_updated_anim()

func play_updated_anim():
	match AnimationType:
		ANIMATION_TYPE.LOOP: sprite.play("PathLoop", -1, speed)
		ANIMATION_TYPE.BOUNCE: sprite.play("PathBounce",-1, speed)
