extends "res://Characters/TemplateCharacter.gd"

var motion = Vector2()

# ======== Scene Functions ========
func _physics_process(delta):
	update_movement()
	move_and_slide(motion)

	
func _input(event):
	if Input.is_action_just_pressed("pi_light_toggle"):
		$Torch.enabled = !$Torch.enabled
	
	if Input.is_action_just_pressed("toggle_night_vision"):
		get_tree().call_group("Interface", "cycle_vision_mode")

# -------- Scene Functions --------

# ======== script functions ========
func update_movement():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp( motion.y - SPEED, -MAX_SPEED, 0 );
	elif Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp( motion.y + SPEED, 0, MAX_SPEED );
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
	
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp( motion.x - SPEED, -MAX_SPEED, 0 );
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp( motion.x + SPEED, 0, MAX_SPEED );
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
# -------- script functions --------
