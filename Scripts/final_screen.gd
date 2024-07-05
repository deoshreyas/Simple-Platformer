extends CanvasLayer

func _ready():
	$Control/VBoxContainer/CoinsCollected.text = "Coin: " + str(Events.coin)
	$Control/VBoxContainer/Time.text = "Time: " + str(snapped(Events.time, 0.01))
	get_tree().paused = true
