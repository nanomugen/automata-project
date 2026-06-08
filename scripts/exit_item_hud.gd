class_name ExitItemHud
extends Control

@onready var enabled: ColorRect = $enabled
@onready var value: Label = $value
var exit:Exit
var enabled_color:Color = Color.BLACK
var label_text:String = "placeholder"

func _ready() -> void:
	pass
func update_exititemhud():
	print("&&&&&&&&&&&&&& update exititemhud")
	if not is_node_ready():
		await ready
	enabled.color = exit.color_opened if exit.opened else exit.color_closed
	value.text = str(exit.goal)
	visible = exit.visited
