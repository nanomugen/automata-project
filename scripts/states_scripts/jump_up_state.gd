class_name JumpUpState extends PlayerState


#region /// state references
#reference to all the other states
#endregion
func init()->void:
	pass
	
func enter()->void:
	human.animation_player.play("jump-up")
	human.velocity.y = human.JUMP_VELOCITY 
	human.jumped_once = true

func exit()->void:
	pass

func handle_input(_event:InputEvent)->PlayerState:
	if _event.is_action_released("jump") and human.velocity.y <0:
		human.velocity.y = 0
		return state_jump_down
	if Input.is_action_just_pressed_by_event("dash",_event) and human.can_dash():
		return state_dash
	if _event.is_action_pressed("attack"):
		return state_attack_air
	return next_state

func process(_delta:float)->PlayerState:
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.allow_human_to_move_h()
	if human.is_on_floor():
		return state_idle_breath
	if human.velocity.y >= 0:
		return state_jump_down
	return next_state
