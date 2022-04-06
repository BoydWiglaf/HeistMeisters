extends CanvasModulate


const DARK = Color("4b4343")
const NIGHT_VISION = Color("13e407")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func vision_mode():
	if color == DARK:
		color = NIGHT_VISION
	else:
		color = DARK
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
