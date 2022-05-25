extends "res://Doors/Door.gd"

export var combination_length : int = 4

func _ready():
	$LockGroup.rect_rotation = -rotation_degrees
	#_inject_combination()


func set_lock_group(group_name):
	$LockGroup.text = group_name


func _on_Door_body_exited(body):
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/Numpad.hide()


func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/Numpad.popup_centered()


func _on_Numpad_combination_correct():
	open_door()


func _inject_combination():
	var combination = CombinationGenerater.get_combination(combination_length)
	$CanvasLayer/Numpad.combination = combination
	print(str(combination))


#This signal must be connected in the level from the computer 
#that will supply the code.
func _on_Computer_set_combination(numbers, lock_group):
	$CanvasLayer/Numpad.combination = numbers
	set_lock_group(lock_group)
