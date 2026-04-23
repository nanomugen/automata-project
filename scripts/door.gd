class_name Door
extends Node2D

@export var buttons: Array[DoorButton]
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_indicator: ColorRect = $StaticBody2D/ColorRect/door_indicator

@export var color_unpressed = Color(1,0,1,0.7)
@export var color_pressed = Color(0,1,1,0.7)

var opened:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_indicator.color = color_unpressed
	for b in buttons:
		if b != null:
			b.color_pressed = color_pressed
			b.color_unpressed = color_unpressed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func verify_buttons():
	if buttons != null:
		var all_pressed = true
		for b in buttons:
			if !b.is_pressed:
				all_pressed = false
				
			
		if all_pressed and !opened:
			opened = true
			door_indicator.color = color_pressed
			animation_player.play("open")
		else:
			if opened:
				opened = false
				door_indicator.color = color_unpressed
				animation_player.play("close")
