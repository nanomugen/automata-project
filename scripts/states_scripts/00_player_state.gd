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

#endregion

func init()->void:
	print("init: ",self)
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
