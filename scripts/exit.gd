class_name Exit
extends Node2D

@onready var color_rect: ColorRect = $Area2D/ColorRect
@onready var label: Label = $Label


@export var nextState: State
@export var goal:int
@export var color_closed:Color = Color(0.7,0.7,0.1,0.7)
@export var color_opened:Color = Color(0.1,0.1,0.7,0.7)
@export var is_final:bool = false

var inside_area:bool = false
var opened:bool = false
func _ready() -> void:
	color_rect.color =  color_closed
	label.text = "0/"+str(goal)

func _process(_delta: float) -> void:
	pass
func reset_exit():
	label.text = "0.0/"+str(goal)
	color_rect.color = color_closed
	inside_area = false
	opened = false
	
func update_opened(current_value) -> void:
	label.text = str(current_value)+"/"+str(goal)
	print("current value: "+str(current_value))
	print("goal: "+str(goal))
	if(current_value == goal):
		opened = true
		color_rect.color = color_opened
		print("current_value == goal")
	else:
		opened = false
		color_rect.color = color_closed
		print("current_value != goal")
	PlayerHudControl.update_exit(self)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	inside_area = true
	PlayerHudControl.add_exit(self)
	
func _on_area_2d_body_exited(_body: Node2D) -> void:
	inside_area = false
