class_name Human extends CharacterBody2D

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
const MAX_FALL_VELOCITY:float = 1500.0


var is_freezed:bool = false


var direction:Vector2 = Vector2.ZERO
var wall_slide_direction:int = 0
var second_jump_enabled:bool = false
var wall_slide_enabled:bool = false
var dash_enabled:bool = false
var dashed_on_air:bool = false
var jumped_once:bool = false
var jumped_twice:bool = false

var coyote_time_started = false
var coyote_time_ended = false
@export var coyote_time:float = 0.125
var is_hitted:bool = false
var is_invincible:bool = false
@export var invincible_time:float = 0.8
var invincible_time_counter:float
var invincible_buffer: HurtableNode2D = null

var cancel_gravity:bool = false
var is_dashing:bool = false
var is_jumping_up:bool = false
var is_wall_sliding:bool = false
var wall_sliding_velocity:float = 100.0

const FLOOR_SNAP_LENGTH = 32.0
const FLOOR_MAX_ANGLE = deg_to_rad(46)
#endregion

#region ///child nodes inspector
@onready var state_label: Label = $StateLabel
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $collision_shape
@onready var camera_2d: GameCamera = $Camera2D

#endregion


func _ready() -> void:
	floor_snap_length = FLOOR_SNAP_LENGTH
	floor_max_angle = FLOOR_MAX_ANGLE
	initialize_states()

func _unhandled_input(event: InputEvent) -> void:
	if is_freezed:return
	change_state(current_state.handle_input(event))

func _process(_delta: float) -> void:
	if is_freezed:return
	update_direction()
	check_invincible(_delta)
	if is_on_floor():
		$debug_nodes/on_floor.color = Color.GREEN
	else:
		$debug_nodes/on_floor.color = Color.RED
	if is_on_wall():
		if is_on_wall_only():
			$debug_nodes/on_wall.color = Color.BLUE
			$debug_nodes/on_wall/Label2.text = "on wall only"
		else:
			$debug_nodes/on_wall.color = Color.GREEN
			$debug_nodes/on_wall/Label2.text = "on wall"
	else:
		$debug_nodes/on_wall.color = Color.RED
		$debug_nodes/on_wall/Label2.text = "on wall"
	 
	
	change_state(current_state.process(_delta))
	
	
func _physics_process(_delta: float) -> void:
	if is_freezed:return
	if is_wall_sliding:
		velocity.y = wall_sliding_velocity
	elif not is_on_floor() and not cancel_gravity:
		velocity.y += get_custom_gravity() * _delta  
		velocity.y = clamp(velocity.y ,velocity.y,MAX_FALL_VELOCITY)
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
	state_label.text = current_state.name
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
	#print("direction: ",direction)
	if is_hitted: return
	#if is_wall_sliding: return
	#var _prev_direction = direction
	#if not is_wall_sliding:
	var x_axis = Input.get_axis("left","right")
	var y_axis = Input.get_axis("up","down")
	direction = Vector2(x_axis,y_axis)
	if is_wall_sliding or is_dashing: return
	if direction.x > 0.0:
		sprite_2d.flip_h = false
	elif direction.x < 0.0:
		sprite_2d.flip_h = true
	
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
	
func hit_damage(damage:Damage,respawn:Marker2D):
	if is_invincible: return
	%state_hitted.current_damage = damage
	%state_hitted.current_respawn = respawn
	change_state(%state_hitted)
	pass
	
func can_jump()->bool:
	if not second_jump_enabled:
		if is_on_floor():return true
		if is_wall_sliding: return true
		if jumped_once:
			return false
		else:
			return true
	else:
		if is_on_floor():return true
		if is_wall_sliding: return true
		if jumped_twice:
			return false
		else:
			return true

	
	
func can_dash()->bool:
	if not dash_enabled: return false
	if is_dashing: return false
	if is_on_floor():
		dashed_on_air = false
		return true
	elif not dashed_on_air:
		return true
	return false

func can_wall_slide()->bool:
	if not wall_slide_enabled: return false
	if is_on_floor(): return false
	return true

func set_invincible()->void:
	is_invincible = true
	invincible_time_counter = invincible_time
	
func check_invincible(delta:float)->void:
	if is_invincible:
		invincible_time_counter -= delta
		if invincible_time_counter <= 0.0:
			is_invincible = false
			sprite_2d.visible = true
			check_pos_invincible()
		else:
			if int(1000* invincible_time_counter) % 7 > 3:
				sprite_2d.visible = !sprite_2d.visible

func check_pos_invincible()->void:
	if invincible_buffer != null:
		hit_damage(invincible_buffer.damage,invincible_buffer.respawn)

func set_hurtable_node(hurtable:HurtableNode2D)->void:
	invincible_buffer = hurtable
	
func remove_hurtable_node(hurtable:HurtableNode2D)->void:
	if invincible_buffer == hurtable:
		invincible_buffer = null
