class_name Exit
extends Node2D

@onready var color_rect: ColorRect = $Area2D/ColorRect
@onready var label: Label = $Label


@export var nextState: State
@export var goal:float
@export var color_closed:Color = Color(0.7,0.7,0.1,0.7)
@export var color_opened:Color = Color(0.1,0.1,0.7,0.7)
@export var is_final:bool = false
var inside_area:bool = false
func _ready() -> void:
	color_rect.color =  color_closed
	label.text = "0.0/"+str(goal)

func _process(delta: float) -> void:
	pass
func reset_exit():
	label.text = "0.0/"+str(goal)
	color_rect.color = color_closed
	inside_area = false

func update_opened(current_value) -> void:
	label.text = str(current_value)+"/"+str(goal)
	if(current_value == goal):
		color_rect.color = color_opened
	else:
		color_rect.color = color_closed

func _on_area_2d_body_entered(body: Node2D) -> void:
	inside_area = true
	print("inside_area: "+ str(inside_area))
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	inside_area = false
