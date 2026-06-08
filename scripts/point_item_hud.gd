class_name PointItemHud
extends Control

@onready var enabled: ColorRect = $enabled
@onready var value: Label = $value
var point:Point

func _init() -> void:
	pass
func _ready() -> void:
	pass
func update_pointitemhud():
	if not is_node_ready():
		await ready
	enabled.color = point.color_pressed if point.is_pressed else point.color_unpressed
	value.text = str(point.value)
	visible = point.visited
	pass
