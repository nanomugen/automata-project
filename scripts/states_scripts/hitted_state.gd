class_name HittedState extends PlayerState


#region /// state references
#reference to all the other states
#endregion

@export var time_of_hitted:float = 0.5

var time_hitted_counter:float = 0.5
var current_damage:Damage;
var current_respawn:Marker2D
signal on_respawn_transition
var ended_animation:bool = false 
#RESOLVER A QUESTÃO DO INVINCIBLE QUE DA PROBLEMA DE ESTAR INVINCIBLE EM CIMA DE UM ESPINHO, 
#USAR O CHECK TALVEZ
var a_position:Vector2

func init()->void:
	
	pass
	
func enter()->void:
	a_position = current_respawn.global_position
	ended_animation = false
	if current_damage.have_respawn:
		human.animation_player.animation_finished.connect(_on_animation_finished)
		on_respawn_transition.connect(respawn_signal_await)
	human.is_hitted = true
	time_hitted_counter = time_of_hitted
	human.animation_player.play("hitted")
	human.collision_shape.disabled = true
	human.velocity.y = human.JUMP_VELOCITY/2
	var custom_direction = -1 if human.sprite_2d.flip_h else 1
	human.velocity.x = custom_direction * human.JUMP_VELOCITY/2
	pass

func exit()->void:
	if current_damage.have_respawn:
		on_respawn_transition.disconnect(respawn_signal_await)
		human.animation_player.animation_finished.disconnect(_on_animation_finished)
	human.is_hitted = false
	human.collision_shape.disabled = false
	human.set_invincible()
	current_damage = null
	current_respawn = null
	pass

func handle_input(_event:InputEvent)->PlayerState:
	return next_state

func process(_delta:float)->PlayerState:
	time_hitted_counter -= _delta
	if time_hitted_counter <= 0.0:
		if current_damage.have_respawn:
			GlobalHud.fade_in_out(1,on_respawn_transition)
	if ended_animation:
		return state_idle_breath
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	
	return next_state

func respawn_signal_await():
	
	human.global_position = a_position
	human.animation_player.play("recover")
	
	pass
	
func _on_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "recover"):
		ended_animation = true
