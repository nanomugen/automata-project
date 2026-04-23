class_name DoorButton
extends Node2D
@onready var button_rect: ColorRect = $ColorRect/button_rect
@onready var button_body: Polygon2D = $ColorRect/button_body
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var color_unpressed = Color(1,0,1,0.7)
var color_pressed = Color(0,1,1,0.7)

var is_pressed:bool = false
var inside_area:bool = false

func _ready() -> void:
	button_rect.color = color_unpressed
	button_body.color = color_unpressed
	
func _process(delta: float) -> void:
	pass
	
func pressed() -> void:
	animation_player.play("press")
	if is_pressed:
		button_rect.color = color_unpressed
		button_body.color = color_unpressed
	else:
		button_rect.color = color_pressed
		button_body.color = color_pressed
	is_pressed = !is_pressed
	
func reset_button():
	button_rect.color = color_unpressed
	button_body.color = color_unpressed
	is_pressed = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	inside_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	inside_area = false
