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
	human.dashed_on_air = false
	human.jumped_once = false
	pass

func exit()->void:
	print("exited: ",name)
	pass

func handle_input(_event:InputEvent)->PlayerState:
	if _event.is_action_pressed("jump") and human.can_jump():
		return state_jump_up
	if Input.is_action_just_pressed_by_event("dash",_event) and human.can_dash():
		return state_dash
	if _event.is_action_pressed("attack"):
		return state_attack_ground
	return next_state

func process(_delta:float)->PlayerState:
	if human.direction.x != 0:
		print("idle to run")
		return state_run
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.velocity.x = 0
	if human.is_on_floor() == false and human.velocity.y >= 0:
		human.jumped_once = true
		return state_jump_down
	return next_state
