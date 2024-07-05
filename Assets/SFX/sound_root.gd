extends Node

@onready var jump = $Jump 
@onready var hurt = $Hurt

func _ready():
	$Bg.play()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)

func play_sound(sound):
	match sound:
		"jump": jump.play()
		"hurt": hurt.play()
