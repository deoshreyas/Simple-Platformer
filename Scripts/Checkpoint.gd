extends Area2D

@onready var active = $Active 
@onready var inactive = $Inactive

func _on_body_entered(body):
	if body is Player:
		Global.checkpoint = body.position
		print(Global.checkpoint)
		inactive.visible = false 
		active.visible = true
