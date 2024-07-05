extends Area2D

func _on_body_entered(body):
	if body is Player:
		(body as Player).player_died()
		Global.instantiate_player()
