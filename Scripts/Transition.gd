extends Node

@onready var animation_player = $AnimationPlayer

signal transition_done

func play_exit_transition():
	animation_player.play("ExitLevel")

func play_enter_transition():
	animation_player.play("EnterLevel")

func _on_animation_player_animation_finished(anim_name):
	transition_done.emit()
