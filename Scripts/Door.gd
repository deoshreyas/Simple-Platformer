extends Area2D

@export var level : PackedScene

func _on_body_entered(body):
	if not body is Player: return 
	if not level: return
	Transition.play_exit_transition()
	await Transition.transition_done
	get_tree().change_scene_to_packed(level)
	Transition.play_enter_transition()
	await Transition.transition_done
