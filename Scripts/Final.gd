extends Area2D

var final_screen = preload("res://Scenes/final_screen.tscn")

func _on_body_entered(body):
	if not body is Player: return
	var final_scr = final_screen.instantiate()
	get_tree().root.add_child(final_scr)
