class_name HittedState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

@export var time_of_hitted:float = 0.5
var can_transition:bool  = false
var time_hitted_counter:float = 0.5
var current_damage:Damage;
var current_respawn:Marker2D
signal on_respawn_transition
var ended_animation:bool = false 
#RESOLVER A QUESTÃO DO INVINCIBLE QUE DA PROBLEMA DE ESTAR INVINCIBLE EM CIMA DE UM ESPINHO, 
#USAR O CHECK TALVEZ
var respawn_position:Vector2

func init()->void:
	
	pass
	
func enter()->void:
	human.camera_2d.apply_shake()
	respawn_position = current_respawn.global_position
	ended_animation = false
	can_transition = false
	if current_damage.have_respawn:
		human.animation_player.animation_finished.connect(_on_animation_finished)
		on_respawn_transition.connect(respawn_signal_await)
	human.is_hitted = true
	time_hitted_counter = time_of_hitted
	human.animation_player.play("hitted")
	human.collision_shape.set_deferred("disabled",true)
	if current_damage.hit_jump:
		human.velocity.y = human.JUMP_VELOCITY *0.8
	var custom_direction = -1 if human.sprite_2d.flip_h else 1
	human.velocity.x = custom_direction * human.JUMP_VELOCITY/2
	pass

func exit()->void:
	if current_damage.have_respawn:
		on_respawn_transition.disconnect(respawn_signal_await)
		human.animation_player.animation_finished.disconnect(_on_animation_finished)
	human.is_hitted = false
	
	human.set_invincible()
	current_damage = null
	current_respawn = null
	pass

func handle_input(_event:InputEvent)->PlayerState:
	return next_state

func process(_delta:float)->PlayerState:
	time_hitted_counter -= _delta
	#if time_hitted_counter <= 0.0:
	if can_transition:
		can_transition = false
		if current_damage.have_respawn:
			GlobalHud.fade_in_out(0.5,on_respawn_transition)
	if ended_animation:
		return state_idle_breath
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	
	return next_state

func respawn_signal_await():
	
	human.global_position = respawn_position
	human.velocity = Vector2.ZERO
	human.sprite_2d.flip_h = true if current_damage.orientation == -1 else false
	human.animation_player.play("recover")
	
	pass
	
func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hitted":
		human.collision_shape.disabled = false
		can_transition = true
	if(anim_name == "recover"):
		ended_animation = true
