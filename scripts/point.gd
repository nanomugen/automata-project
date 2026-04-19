class_name Point
extends Node2D

@onready var color_rect: ColorRect = $Area2D/ColorRect
@export var value:int;
@export var color_unpressed = Color(1,0,0,0.7)
@export var color_pressed = Color(0,10,0,0.7)
var is_pressed:bool = false
var inside_area:bool = false
func _ready() -> void:
	color_rect.color = color_unpressed

func pressed() -> void:
	if is_pressed:
		color_rect.color = color_unpressed
		
	else:
		color_rect.color = color_pressed
	is_pressed = !is_pressed
	PlayerHudControl.add_point(self)
	
func reset_button():
	color_rect.color = color_unpressed
	is_pressed = false
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	#color_rect.color = color_unpressed
	print("entered")
	inside_area = true
	PlayerHudControl.add_point(self)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	#color_rect.color = color_unpressed
	print("exited")
	inside_area = false
