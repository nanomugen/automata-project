class_name IdleState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

func init()->void:
	pass
	
func enter()->void:
	human.animation_player.play("idle-breath")
	human.is_jumping_up = false
	print("entered: ",name)
	pass

func exit()->void:
	print("exited: ",name)
	pass

func handle_input(_event:InputEvent)->PlayerState:
	if _event.is_action_pressed("jump") and human.can_jump():
		return state_jump_up
	if _event.is_action_pressed("dash") and human.can_dash():
		if _event.axis_value >0.5:
			return next_state
		print("###event: ",_event)
		return state_dash
	return next_state

func process(_delta:float)->PlayerState:
	if human.direction.x != 0:
		print("idle to run")
		return state_run
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.velocity.x = 0
	if human.is_on_floor() == false and human.velocity.y >= 0:
		return state_jump_down
	return next_state
