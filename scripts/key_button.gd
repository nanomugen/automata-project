extends Control
class_name KeyButton
@onready var label: Label = $ColorRect/ColorRect/Label
@onready var color_rect_gray: ColorRect = $ColorRect
@onready var color_rect_white: ColorRect = $ColorRect/ColorRect


@export var button_label:String = " "
@export var white_key_size:int = 35
@export var gray_key_size:int = 45
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = button_label
	color_rect_gray.size.x = gray_key_size
	color_rect_white.size.x = white_key_size
	color_rect_white.position.x = (gray_key_size - white_key_size)/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
