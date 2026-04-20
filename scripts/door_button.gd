class_name DoorButton
extends Node2D
@onready var button_rect: ColorRect = $ColorRect/button_rect
@export var color_unpressed = Color(1,0,1,0.7)
@export var color_pressed = Color(0,1,1,0.7)

var is_pressed:bool = false
var inside_area:bool = false

func _ready() -> void:
	button_rect.color = color_unpressed
	
func _process(delta: float) -> void:
	pass
	
func pressed() -> void:
	if is_pressed:
		button_rect.color = color_unpressed
	else:
		button_rect.color = color_pressed
	is_pressed = !is_pressed
	
func reset_button():
	button_rect.color = color_unpressed
	is_pressed = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	inside_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	inside_area = false
