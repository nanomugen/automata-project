class_name Door
extends Node2D

@export var buttons: Array[DoorButton]
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_indicator: ColorRect = $StaticBody2D/ColorRect/door_indicator

var opened:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_indicator.color = buttons[0].color_unpressed


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
			door_indicator.color = buttons[0].color_pressed
			animation_player.play("open")
		else:
			if opened:
				opened = false
				door_indicator.color = buttons[0].color_unpressed
				animation_player.play("close")
