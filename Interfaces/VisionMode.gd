extends CanvasModulate


const DARK = Color("111111")
const NIGHT_VISION = Color("13e407")

var has_cooldown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	color = DARK

func cycle_vision_mode():
	if not has_cooldown:	
		if color != NIGHT_VISION:
			night_mode()
		else:
			dark_mode()
		has_cooldown = true
		$Timer.start()

func night_mode():
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	color = NIGHT_VISION
	get_tree().call_group("lights", "hide")
	get_tree().call_group("labels", "show")
	
func dark_mode():
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	color = DARK
	get_tree().call_group("lights", "show")
	get_tree().call_group("labels", "hide")

func _on_Timer_timeout():
	has_cooldown = false
	
