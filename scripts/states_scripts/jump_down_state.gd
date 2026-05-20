class_name JumpDownState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

func init()->void:
	pass
	
func enter()->void:
	human.animated_sprite_2d.play("jump-down")
	pass

func exit()->void:
	pass

func handle_input(_event:InputEvent)->PlayerState:
	return next_state

func process(_delta:float)->PlayerState:
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.allow_human_to_move_h()
	if human.is_on_floor():
		return state_idle_breath
	return next_state
