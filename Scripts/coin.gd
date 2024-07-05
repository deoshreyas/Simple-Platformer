extends Area2D
class_name Coin 

func _on_body_entered(body):
	if not body is Player: return
	Events.coin += 1
	queue_free()
	SoundRoot.play_sound("coin")
