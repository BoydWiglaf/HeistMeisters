extends Popup



func _on_ReplayButton_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_NextLevelButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Levels/MainMenue.tscn")
