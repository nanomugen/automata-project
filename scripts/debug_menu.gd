extends CanvasLayer
class_name DebugMenu
@onready var double_jump_button: CheckButton = $PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer3/DoubleJumpButton
@onready var wall_slide_button: CheckButton = $PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer2/WallSlideButton
@onready var dash_button: CheckButton = $PanelContainer/HBoxContainer/VBoxContainer/HBoxContainer/DashButton
var human:Human
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	human = get_parent().find_children("","Human").get(0)
	#human = find_children("","Human").get(0)
	if human != null:
		print("!=null")
	else:
		print("null")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_double_jump_button_toggled(toggled_on: bool) -> void:
	#human = get_parent().find_children("","Human").get(0)
	if human == null: return
	human.second_jump_enabled = toggled_on

func _on_dash_button_toggled(toggled_on: bool) -> void:
	if human == null: return
	human.dash_enabled = toggled_on

func _on_wall_slide_button_toggled(toggled_on: bool) -> void:
	if human == null: return
	human.wall_slide_enabled = toggled_on
