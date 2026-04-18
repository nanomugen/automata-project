class_name Human
extends CharacterBody2D

#ver se da pra colocar uma curva nesses parametros para acelerar da forma correta esses movimentos
@export var SPEED = 400.0
@export var DASH_SPEED = 700.0
@export var jump_height: float = 150.0
@export var jump_time_to_peak: float = 0.4
@export var jump_time_to_descent: float = 0.3

@onready var test_rect: ColorRect = $test_rect

@onready var jump_velocity:float = (2.0 * jump_height)/jump_time_to_peak * -1.0
@onready var jump_gravity:float = (-2.0 * jump_height)/(jump_time_to_peak * jump_time_to_peak) * -1.0
@onready var fall_gravity:float = (-2.0 * jump_height)/(jump_time_to_descent * jump_time_to_descent) * -1.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer_dash: Timer = $timer_dash
@onready var timer_dash_cooldown: Timer = $timer_dash_cooldown
@onready var time_idle_wait: Timer = $time_idle_wait
@onready var timer_coyote_jump: Timer = $timer_coyote_jump


var dashing: bool = false
var can_dash: bool = true
var orientation = 1
var cancel_gravity = false
var attack: bool = false
var dashed_once:bool = false
var cancel_control:bool = false
var freeze:bool = false
var coyote_jump:bool = true
var jump_pressed:bool = true

var idle_wait:bool = false
var play_breath:bool =true
var random:RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	random.randomize()
	
func _physics_process(delta: float) -> void:
	if freeze:
		return
	if not is_on_floor():
		test_rect.color = Color(1,1,0)
		if !jump_pressed and !coyote_jump:
			coyote_jump = true
			#test_rect.color = Color(0,1,0)
			timer_coyote_jump.start()
			print("started")
		if !cancel_gravity:
			velocity.y += get_gravity2() * delta
			velocity.y = clamp(velocity.y,velocity.y,1500)
	else:
		test_rect.color = Color(0,0,1)
		timer_coyote_jump.stop()
		#test_rect.color = Color(1,0,0)
		coyote_jump = false
		jump_pressed=false
		dashed_once = false
	if cancel_control:
		velocity.x = 0
		move_and_slide()
		return	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_jump) and !jump_pressed:
		
		jump()
		if dashing:
			cancel_gravity = false
			timer_dash.start()
	if Input.is_action_just_released("jump"):# and jumping_action:
		interrupt_jump();
		
	if Input.is_action_just_pressed("attack") and !attack:
		attack = true
		
	var direction := Input.get_axis("move_left", "move_right")
	if direction == 1 or direction == -1:
		orientation = direction
	if Input.is_action_just_pressed("dash") and !dashing and can_dash and !dashed_once:
		cancel_gravity = true
		dashing = true
		timer_dash.start()
		velocity.y = 0
		velocity.x = orientation * DASH_SPEED
		can_dash = false
		dashed_once = true
	# Get the input direction: -1, 0, 1
	
	#ANIMATION
	if dashing :
		animated_sprite.play("dash")
		idle_wait = false
		play_breath = true
		#attack = false
	else:
		if(attack):
			idle_wait = false
			play_breath = true
			if !animated_sprite.animation.begins_with("attack"):
				if(is_on_floor()):
					animated_sprite.play("attack-ground")
				else:
					animated_sprite.play("attack-air")
				#attack = false
		else:		
			if is_on_floor():
				if direction == 0:
					if play_breath:
						animated_sprite.play("idle-breath")
					if !idle_wait:
						idle_wait = true
						time_idle_wait.start()
				else:
					animated_sprite.play("walk")
					if idle_wait and !time_idle_wait.is_stopped():
						time_idle_wait.stop()
						idle_wait = false
						play_breath = true
						
			else:
				animated_sprite.play("jump-up")
				idle_wait = false
				play_breath = true
	#flip the sprite
	if direction > 0 :
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#apply movement
	if !dashing:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func get_gravity2() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity;
func jump() -> void:
	jump_pressed = true
	velocity.y = jump_velocity
	
func interrupt_jump():
	if velocity.y < 0:
		velocity.y = 0
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation.begins_with("attack"):
		attack = false
	if animated_sprite.animation.begins_with("idle-look") or animated_sprite.animation.begins_with("idle-blink"):
		idle_wait = false
		play_breath = true

func _on_timer_dash_timeout() -> void:
	cancel_gravity = false
	dashing = false
	velocity.x = 0
	timer_dash.stop()
	timer_dash_cooldown.start()

func _on_timer_dash_cooldown_timeout() -> void:
	timer_dash_cooldown.stop()
	can_dash = true
	


func _on_time_idle_wait_timeout() -> void:
	#print("_on_time_idle_wait_timeout()")
	play_breath = false
	if random.randi()%2 == 0:
		animated_sprite.play("idle-look") # Replace with function body.
	else:
		animated_sprite.play("idle-blink") 

func _on_timer_coyote_jump_timeout() -> void:
	timer_coyote_jump.stop()
	coyote_jump = false
	#test_rect.color = Color(1,0,0)
	jump_pressed = true
	print("finished")
