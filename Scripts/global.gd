extends Node

var checkpoint : Vector2

var player = preload("res://Scenes/player.tscn")

const PLAYER_START_POS = Vector2(215, 14)

func get_last_checkpoint_pos():
	if checkpoint != null:
		return checkpoint 
	else:
		return PLAYER_START_POS

func instantiate_player():
	var world = get_tree().change_scene_to_file("res://Scenes/world.tscn")
	var player_instance = world.instantiate(player)
	player_instance.position = get_last_checkpoint_pos()

func _ready():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	var player_instance = world.instantiate(player)
	player_instance.position = get_last_checkpoint_pos()
