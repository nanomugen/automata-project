class_name DashState extends PlayerState


#region /// state references
#reference to all the other states
#endregion
@export var dash_time:float = 0.25
var dash_time_count:float
@export var dash_cooldown:float = 0.3 #seria aqui?
func init()->void:
	pass
	
func enter()->void:
	human.animation_player.play("dash")
	human.cancel_gravity = true
	dash_time_count = dash_time
	human.velocity.y = 0.0
	var orientation = -1 if human.sprite_2d.flip_h else 1
	human.velocity.x = human.DASH_SPEED * orientation
	human.is_dashing = true
	if not human.is_on_floor():
		human.dashed_on_air = true
	else:
		human.jumped_once = false

func exit()->void:
	human.cancel_gravity = false
	human.is_dashing = false
	pass

func handle_input(_event:InputEvent)->PlayerState:
	if _event.is_action_pressed("jump") and human.can_jump():
		return state_jump_up
	if _event.is_action_pressed("attack"):
		return state_attack_dash
	return next_state

func process(_delta:float)->PlayerState:
	dash_time_count -= _delta
	if dash_time_count <= 0 :
		if human.is_on_floor():
			return state_idle_breath
		else:
			return state_jump_down
	
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	return next_state
