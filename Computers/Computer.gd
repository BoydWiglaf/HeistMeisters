extends Area2D

var _can_click : bool = false

var combination

export var combination_length : int = 4
export var lock_group = "Unset"

signal set_combination

func _ready():
	$LockGroup.rect_rotation = -rotation_degrees
	generate_combination()
	emit_signal("set_combination", combination, lock_group)
	set_lock_group(lock_group)


func set_lock_group(group_name):
	$LockGroup.text = group_name
	
	
func generate_combination():
	combination = CombinationGenerater.get_combination(combination_length)
	_set_popup_text()
	
	
func _set_popup_text():
	$CanvasLayer/ComputerPopup.set_text(combination)

	
func _on_Computer_body_entered(body):
	_can_click = true


func _on_Computer_body_exited(body):
	_can_click = false
	$CanvasLayer/ComputerPopup.hide()
	$Light2D.enabled = false


func _on_Computer_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and _can_click:
		$Light2D.enabled = true
		$CanvasLayer/ComputerPopup.popup_centered()
