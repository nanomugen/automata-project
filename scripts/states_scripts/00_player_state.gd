class_name PlayerState extends Node

var human : Human
var next_state : PlayerState

#region /// state references
@onready var state_run: RunState = %state_run
@onready var state_idle_breath: IdleState = %state_idle_breath
@onready var state_jump_up: JumpUpState = %state_jump_up
@onready var state_jump_down: JumpDownState = %state_jump_down
@onready var state_dash: DashState = %state_dash
@onready var state_hitted: HittedState = %state_hitted
@onready var state_attack_ground: AttackGroundState = %state_attack_ground
@onready var state_attack_air: AttackAirState = %state_attack_air
@onready var state_attack_run: AttackRunState = %state_attack_run
@onready var state_attack_dash: AttackDashState = %state_attack_dash
@onready var state_wall_slide: WallSlideState = %state_wall_slide
@onready var state_jump_wall_slide: JumpWallSlideState = %state_jump_wall_slide

#endregion

func init()->void:
	pass
	
func enter()->void:
	print("enter: ",self)
	pass

func exit()->void:
	print("exit: ",self)
	pass

func handle_input(_event:InputEvent)->PlayerState:
	return next_state

func process(_delta:float)->PlayerState:
	return next_state
	
func physics_process(_delta:float)->PlayerState:
	return next_state
