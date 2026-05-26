class_name AttackGroundState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

var finished_attack:bool = false
func init()->void:
	
	pass
	
###############################################
#TODO
#FAZER COM QUE A FUNÇÃO DE ATAQUE ACONTEÇA NO FRAME DE ATAQUE, CASO SEJA CANCELADO ANTES, O ATTACK ELE NÃO DEVE ACONTECER
func enter()->void:
	human.animation_player.play("attack-idle")
	human.animation_player.animation_finished.connect(_on_animation_finished)
	pass

func exit()->void:
	finished_attack = false
	human.animation_player.animation_finished.disconnect(_on_animation_finished)

	pass

func handle_input(_event:InputEvent)->PlayerState:
	if _event.is_action_pressed("jump") and human.can_jump():
		return state_jump_up
	return next_state

func process(_delta:float)->PlayerState:
	if finished_attack:
		if human.is_on_floor():
			if human.velocity.x == 0.0:
				return state_idle_breath
			else:
				return state_run
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	human.allow_human_to_move_h()
	return next_state


func _on_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "attack-idle"):
		finished_attack = true
