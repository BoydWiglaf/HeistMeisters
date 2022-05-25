extends "res://Characters/TemplateCharacter.gd"

var motion = Vector2()

export var disguise_slowdown:float = 0.25
export var disguise_countdown:float = 5
export var number_of_disguises:int = 3

var velocity_multiplier:float = 1
var _is_disguised = false

const PLAYER_SPRITE = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const PLAYER_LIGHT = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE = "res://GFX/PNG/Tiles/tile_130.png"
const BOX_LIGHT = "res://GFX/PNG/Tiles/tile_130.png"
const PERSON_OCCLUDER = "res://Characters/Person_Occluder.tres"
const BOX_OCCLUDER = "res://Characters/Box_Occluder.tres"

onready var disguise_countdown_label = $LabelDisguiseCountdown


# ======== Scene Functions ========
func _ready():
	$Timer.wait_time = disguise_countdown
	reveal()
	get_tree().call_group("DisguiseDisplay", "update_disguises", number_of_disguises)

func _physics_process(delta):
	update_movement()
	move_and_slide(motion * velocity_multiplier)
	disguise_countdown_label.text = str($Timer.time_left).pad_decimals(2)
	disguise_countdown_label.rect_rotation = -rotation_degrees
	
func _input(event):
	#if Input.is_action_just_pressed("pi_light_toggle"):
	#	$Torch.enabled = !$Torch.enabled
	
	if Input.is_action_just_pressed("toggle_night_vision"):
		get_tree().call_group("Interface", "cycle_vision_mode")
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()

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


func toggle_disguise():
	if _is_disguised:
		reveal()
	elif number_of_disguises > 0:
		disguise()


func reveal():
	$Sprite.texture = load(PLAYER_SPRITE)
	$LightOccluder2D.occluder = load(PERSON_OCCLUDER)
	$Light2D.texture = load(PLAYER_LIGHT)
	disguise_countdown_label.hide()
	velocity_multiplier = 1
	
	collision_layer = 1
	_is_disguised = false
	
func disguise():
	$Sprite.texture = load(BOX_SPRITE)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
	$Light2D.texture = load(BOX_LIGHT)
	disguise_countdown_label.show()
	
	$Timer.start()
	velocity_multiplier = disguise_slowdown
	number_of_disguises -= 1
	
	collision_layer = 16
	_is_disguised = true
	get_tree().call_group("DisguiseDisplay", "update_disguises", number_of_disguises)


func collect_briefcase():
	var node = Node.new()
	node.name = "Briefcase"
	add_child(node)
	get_tree().call_group("Loot", "collected_loot")




# -------- script functions --------
