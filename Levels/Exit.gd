extends ColorRect

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _on_Area2D_body_entered(body):
	if body.has_node("Briefcase"):
		get_tree().paused = true
		$CanvasLayer/VictoryScreen.popup_centered()
