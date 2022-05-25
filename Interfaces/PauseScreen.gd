extends Popup

var is_game_paused = false
var is_menu_open = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not is_game_paused:
		is_game_paused = true
		popup_centered()
		get_tree().paused = true
	elif Input.is_action_just_pressed("ui_cancel") and is_game_paused:
		hide()
		get_tree().paused = false
		is_game_paused = false

func _on_ResumeButton_pressed():
	hide()
	is_game_paused = false
	get_tree().paused = false


func _on_RestartButton_pressed():
	get_tree().paused = false
	is_game_paused = false
	get_tree().reload_current_scene()
#	var root = get_tree().get_root()
#	var path = root.get_child(root.get_child_count() -1)
#	print(path.get_path())
#	get_tree().change_scene(str(path.get_path()))


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_LoadMainButton_pressed():
	is_game_paused = false
	get_tree().paused = false
	get_tree().change_scene("res://Levels/MainMenue.tscn")
