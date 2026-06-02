class_name RunState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

func init()->void:
	pass
	
func enter()->void:
	human.animation_player.play("run")
	human.is_jumping_up = false
	print("entered: ",name)
	human.dashed_on_air = false
	human.jumped_once = false
	human.jumped_twice = false
	pass

func exit()->void:
	human.reset_coyote_variables()
	print("exited: ",name)
	pass

func handle_input(_event:InputEvent)->PlayerState:
	if _event.is_action_pressed("jump") and human.can_jump():
		return state_jump_up
	if Input.is_action_just_pressed_by_event("dash",_event) and human.can_dash():
		return state_dash
	if _event.is_action_pressed("attack"):
		return state_attack_run
	return next_state

func process(_delta:float)->PlayerState:
	if human.direction.x == 0 :
		return state_idle_breath
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.allow_human_to_move_h()
	if human.is_on_floor() == false and human.velocity.y >= 0:
		if human.coyote_time_started == false:
			human.coyote_time_start()
		if human.coyote_time_ended == true:
			human.jumped_once = true
			return state_jump_down
	return next_state
