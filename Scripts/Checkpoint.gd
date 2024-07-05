extends Area2D

var active = true

func _on_body_entered(body):
	if not body is Player: return 
	if not active: return
	$AnimatedSprite2D.play("checked")
	active = false
	Events.hit_checkpoint.emit(position)
