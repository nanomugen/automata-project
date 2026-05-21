class_name Human2 extends CharacterBody2D

#region ///state machine variables
var states: Array[PlayerState]
var current_state:PlayerState:
	get : return states.front()
var previous_state:PlayerState:
	get: return states[1] if states.size() > 1 else null
#endregion

#region /// standard variables
@export var SPEED = 320.0
@export var DASH_SPEED = 700.0
@export var JUMP_HEIGHT: float = 150.0
@export var JUMP_TIME_TO_PEAK: float = 0.4
@export var JUMP_TIME_TO_DESCEND: float = 0.3

@onready var JUMP_VELOCITY:float = (2.0 * JUMP_HEIGHT)/JUMP_TIME_TO_PEAK * -1.0
@onready var JUMP_GRAVITY:float = (-2.0 * JUMP_HEIGHT)/(JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK) * -1.0
@onready var FALL_GRAVITY:float = (-2.0 * JUMP_HEIGHT)/(JUMP_TIME_TO_DESCEND * JUMP_TIME_TO_DESCEND) * -1.0
var MAX_FALL_VELOCITY:float = 1500.0

var is_freezed:bool = false
var direction:Vector2 = Vector2.ZERO
var second_jump_enabled:bool = false
var wall_slide_enabled:bool = false

var coyote_time_started = false
var coyote_time_ended = false
@export var coyote_time:float = 0.125

#endregion

#region ///child nodes inspector
@onready var state_label: Label = $StateLabel
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#endregion


func _ready() -> void:
	initialize_states()

func _unhandled_input(event: InputEvent) -> void:
	#print("unhandled input")
	if is_freezed:return
	change_state(current_state.handle_input(event))

func _process(_delta: float) -> void:
	if is_freezed:return
	update_direction()
	
	
	change_state(current_state.process(_delta))
	
	
func _physics_process(_delta: float) -> void:
	if is_freezed:return
	
	var gravity = get_custom_gravity()
	var new_velocity = velocity.y + gravity * _delta  
	velocity.y = clamp(new_velocity ,new_velocity,MAX_FALL_VELOCITY)
	#velocity.y = new_velocity
	#print(velocity.y)
	move_and_slide() 
	change_state(current_state.physics_process(_delta))
	
func initialize_states() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			states.append(c)
			c.human = self
			#c.init()
	if states.size() == 0:
		return
	for state in states:
		state.init()
	#print(states)
	#states.append(%state_idle_breath)
	state_label.text = current_state.name
	#change_state(current_state)
	current_state.enter()
	
func change_state( new_state:PlayerState)-> PlayerState:
	if new_state == null:return
	if new_state == current_state:return
	
	if current_state:
		current_state.exit()
	states.push_front(new_state)
	current_state.enter()
	print(current_state.name)
	states.resize(3)
	state_label.text = current_state.name
 	
	return null

func update_direction() ->void:
	#var _prev_direction = direction
	var x_axis = Input.get_axis("left","right")
	var y_axis = Input.get_axis("up","down")
	direction = Vector2(x_axis,y_axis)
	if direction.x > 0.0:
		animated_sprite_2d.flip_h = false
	elif direction.x < 0.0:
		animated_sprite_2d.flip_h = true
	
func get_custom_gravity()->float:
	return JUMP_GRAVITY if velocity.y < 0.0 else FALL_GRAVITY;
func allow_human_to_move_h():
	velocity.x = direction.x * SPEED

func reset_coyote_variables():
	coyote_time_started = false
	coyote_time_ended = true

func coyote_time_start():
	$debug_nodes/coyote_time_rect.color = Color.GREEN
	coyote_time_started = true
	coyote_time_ended = false
	await get_tree().create_timer(coyote_time).timeout
	coyote_time_ended = true
	$debug_nodes/coyote_time_rect.color = Color.RED
