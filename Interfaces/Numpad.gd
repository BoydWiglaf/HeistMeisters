extends Popup

var combination = [0,4,5,1]
var guess = []

onready var display = $VboxContainer/DisplayContainer/Display
onready var light = $VboxContainer/ButtonContainer/GridContainer/StatusLight
onready var grid_container = $VboxContainer/ButtonContainer/GridContainer.get_children()
onready var audio_stream = $AudioStreamPlayer

signal combination_correct

func _ready():
	connect_buttons()
	reset_lock()
	
func connect_buttons():
	for child in grid_container:
		if child is Button:
			child.connect("pressed", self, "Button_pressed", [child.text])
			
			
func Button_pressed(button):
	audio_stream.stream = load("res://SFX/button_tone_2.wav")
	audio_stream.play()
	if button == "OK":
		check_guess()
	else:
		enter(int(button))
	
func check_guess():
	if guess == combination:
		light.texture = load("res://GFX/Interface/PNG/dotGreen.png")
		$Timer.start()
		audio_stream.stream = load("res://SFX/Menu_FX_example/Menu1A.wav")
		audio_stream.play()
		
	else:
		reset_lock()
		audio_stream.stream = load("res://SFX/Menu_FX_example/Menu1B.wav")
		audio_stream.play()
	
func enter(button):
	guess.append(button)
	update_display()
	
func update_display():
	display.text = PoolStringArray(guess).join("")
	if guess.size() == combination.size():
		check_guess()	
	
func reset_lock():
	display.text = ""
	guess.clear()
	light.texture = load("res://GFX/Interface/PNG/dotRed.png")




func _on_Timer_timeout():
	emit_signal("combination_correct")
	reset_lock() #TODO: Replace this with an animation that lets the player know they unlocked the door
	hide()
