class_name JumpUpState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

func init()->void:
	pass
	
func enter()->void:
	human.animated_sprite_2d.play("jump-up")
	human.velocity.y = human.JUMP_VELOCITY 
	pass

func exit()->void:
	pass

func handle_input(_event:InputEvent)->PlayerState:
	if _event.is_action_released("jump") and human.velocity.y <0:
		human.velocity.y = 0
		return state_jump_down
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
