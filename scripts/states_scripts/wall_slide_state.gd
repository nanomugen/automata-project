class_name WallSlideState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

func init()->void:
	pass
	
func enter()->void:
	human.animation_player.play("wall_slide")
	human.is_wall_sliding = true
	human.is_jumping_up = false
	human.dashed_on_air = false
	human.jumped_once = false
	human.jumped_twice = false
	human.velocity.x = 0
	
	pass

func exit()->void:
	human.is_wall_sliding = false
	
	pass

func handle_input(_event:InputEvent)->PlayerState:
	
	if _event.is_action_pressed("jump") and human.can_jump():
		return state_jump_wall_slide
	if Input.is_action_just_pressed_by_event("dash",_event) and human.can_dash():
		return state_dash
	if _event.is_action_pressed("attack"):
		return state_attack_run #ATTACK_WALL_SLIDE_STATE
	return next_state

func process(_delta:float)->PlayerState:
	if not human.is_on_wall_only(): return state_jump_down
	if human.direction.x > 0.0 and human.wall_slide_direction == 1:
		return state_jump_down
		
	if human.direction.x < 0.0 and human.wall_slide_direction == -1:
		return state_jump_down

	if human.is_on_floor():
		return state_idle_breath
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	
	#human.allow_human_to_move_h()
	return next_state
