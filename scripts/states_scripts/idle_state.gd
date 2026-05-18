class_name IdleState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

func init()->void:
	pass
	
func enter()->void:
	human.animated_sprite_2d.play("idle-breath")
	print("entered: ",name)
	pass

func exit()->void:
	print("exited: ",name)
	pass

func handle_input(_event:InputEvent)->PlayerState:
	
	
	return next_state

func process(_delta:float)->PlayerState:
	if human.direction.x != 0:
		print("idle to run")
		return state_run
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.velocity.x = 0
	return next_state
