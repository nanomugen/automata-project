class_name JumpWallSlideState extends PlayerState

@export var delay_change_direction:float = 0.1
var delay_change_direction_count:float
#region /// state references
#reference to all the other states
#endregion
func init()->void:
	pass
	
func enter()->void:
	delay_change_direction_count = delay_change_direction
	human.animation_player.play("jump-up")
	human.velocity.y = human.JUMP_VELOCITY
	human.velocity.x = -human.wall_slide_direction * human.JUMP_VELOCITY * 0.4
	human.jumped_once = true
	print("human.direction: ",human.direction) 

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
	if human.is_on_wall_only():
		if human.direction.x < 0.0:
			var collision = human.get_last_slide_collision()
			var normal = collision.get_normal()
			# Check if the wall is to the left
			if normal.x > 0:
				human.wall_slide_direction = 1
				human.sprite_2d.flip_h = false
				return state_wall_slide
		
		elif human.direction.x > 0.0:
			var collision = human.get_last_slide_collision()
			var normal = collision.get_normal()
		# Check if the wall is to the right
			if normal.x < 0:
				human.wall_slide_direction = -1
				human.sprite_2d.flip_h = true
				return state_wall_slide
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	if delay_change_direction_count < 0.0:
		human.allow_human_to_move_h()
		
	else:
		delay_change_direction_count -= _delta
	
	if human.is_on_floor():
		return state_idle_breath
	if human.velocity.y >= 0:
		return state_jump_down
	return next_state
