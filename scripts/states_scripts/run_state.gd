class_name RunState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

func init()->void:
	pass
	
func enter()->void:
	human.animated_sprite_2d.play("walk")
	print("entered: ",name)
	pass

func exit()->void:
	print("exited: ",name)
	pass

func handle_input(_event:InputEvent)->PlayerState:
	
	return next_state

func process(_delta:float)->PlayerState:
	if human.direction.x == 0 :
		print("run to idle")
		return state_idle_breath
	if human.direction.x >0:
		human.animated_sprite_2d.flip_h = false
	else:
		human.animated_sprite_2d.flip_h = true
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.velocity.x = human.direction.x * human.SPEED
	return next_state
