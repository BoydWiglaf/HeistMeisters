extends Node2D

onready var audio = $AudioStreamPlayer

var objective_markers = []
var objective_messages = []

func _ready():
	objective_markers = make_list_of_positioins()
	objective_messages = make_list_of_messages()
	print(objective_messages)
	update_marker_position(0)

func update_marker_position(objective_number):
	var pointer = $ObjectiveMarker
	var place = objective_markers[objective_number]
	var message = objective_messages[objective_number]
	$TutorialGUI/AnimationPlayer.play("TextBoxAnimaation")
	$TutorialGUI/Control/NinePatchRect/Label.text = message
	$Tween.interpolate_property(pointer, "position", pointer.position,
		place, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
var has_move = false
func _on_MoveObjective_body_entered(body):
	if not has_move:
		has_move = true
		update_marker_position(1)
		audio.play()
	
	
var has_door = false	
func _on_DoorObjective_body_entered(body):
	if not has_door:
		has_door = true
		update_marker_position(2)
		audio.play()
var has_night = false
func _on_NightVisionObjective_body_entered(body):
	get_tree().call_group("Interface", "dark_mode")
	if not has_night:
		has_night = true
		update_marker_position(3)
		audio.play()

var has_avoid = false
func _on_AvoidObjective_body_entered(body):
	if not has_avoid:
		has_avoid = true
		update_marker_position(4)
		audio.play()
var has_brief = false
func _on_BriefcaseObjective_body_entered(body):
	if not has_brief:
		has_brief = true
		update_marker_position(5)
		audio.play()

var has_lock_picked = false
func _on_LockedDoorObjective2_body_entered(body):
	if not has_lock_picked:
		has_lock_picked = true
		$TutorialGUI/Control/NinePatchRect/Label.text = "Great Job!  Oohh. Thats alot of cameras.  Good thing you have your disguse. [E]"
		$Tween.interpolate_property($ObjectiveMarker, "position", $ObjectiveMarker.position,
			$Exit.rect_global_position, 1.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
		audio.play()

func make_list_of_positioins():
	var markers = []
	var object_areas = $ObjectiveAreas.get_children()
	
	for node in object_areas:
		var pos = node.position
		var child_pos = node.get_child(1).position
		markers.append(pos + child_pos)
	return markers

func make_list_of_messages():
	var messages = []
	var objective_areas = $ObjectiveAreas.get_children()

	for node in objective_areas:
		var message = node.get_child(2).message
		messages.append(message)
	return messages

