extends Node

@onready var jump = $Jump 
@onready var hurt = $Hurt
@onready var coin = $Coin

func _ready():
	$Bg.play()

func play_sound(sound):
	match sound:
		"jump": jump.play()
		"hurt": hurt.play()
		"coin": coin.play()
