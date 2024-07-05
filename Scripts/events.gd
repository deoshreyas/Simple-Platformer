extends Node

var time = 0.0

func _process(delta):
	time += delta

var coin = 0:
	get:
		return coin 
	set(value):
		coin = value
		change_coin_amount.emit(coin)

signal player_died
signal hit_checkpoint(checkpoint_pos)

signal change_coin_amount(coin)
