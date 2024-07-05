extends Label

func _ready():
	Events.connect("change_coin_amount", _update_coins)
	text = str(Events.coin)
	
func _update_coins(amount):
	text = str(amount)
