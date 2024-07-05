extends Node2D

var player_scene = preload("res://Scenes/player.tscn")

var player_spawn_pos: Vector2

@onready var camera = $Camera2D
@onready var player = $Player

func _ready():
	player.connect_camera(camera)
	Events.connect("player_died", _on_player_died)
	Events.connect("hit_checkpoint", _on_hit_checkpoint)
	player_spawn_pos = player.position
	
func _on_player_died():
	var new_player = player_scene.instantiate()
	new_player.position = player_spawn_pos
	add_child(new_player)
	new_player.connect_camera(camera)
	
func _on_hit_checkpoint(pos):
	player_spawn_pos = pos
