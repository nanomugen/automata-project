class_name Point
extends Node2D

@onready var color_rect: ColorRect = $Area2D/ColorRect
@export var value:float;
var is_pressed:bool = false
var inside_area:bool = false
func _ready() -> void:
	color_rect.color = Color(1,0,0,0.7)

func pressed() -> void:
	if is_pressed:
		color_rect.color = Color(1,0,0,0.7)
		
	else:
		color_rect.color = Color(0,1,0,0.7)
	is_pressed = !is_pressed
	
func reset_button():
	color_rect.color = Color(1,0,0,0.7)
	is_pressed = false
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	#color_rect.color = Color(1,0,0,0.7)
	print("entered")
	inside_area = true
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	#color_rect.color = Color(0,1,0,0.7)
	print("exited")
	inside_area = false
