extends TextureProgress

export var suspicion_multiplyer = 4

#TODO: add a var and a func to change the Tint Progress
	# for accesability options

func _ready():
	value = 0
	
func _process(delta):
	if value == max_value:
		failed_mission()
	value -= step
	
func player_seen():
	value += (step * suspicion_multiplyer)

func end_game():
	get_tree().quit()

func failed_mission():
	get_tree().call_group("failed","show_failed_popup")
	
