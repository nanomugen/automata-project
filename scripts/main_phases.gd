class_name MainPhases
extends Node2D

@onready var fade_trasition: ColorRect = $fade_trasition
@onready var reset_phases_button: Button = $options_control/reset_phases_button

var tween:Tween

var phases:Dictionary = DataSystem.DATA_OBJECT["phases"]

func _process(_delta):
	if Input.is_action_pressed("dash") and Input.is_action_pressed("attack"):
		reset_phases_button.visible = true

func _ready():
	print(DataSystem.DATA_OBJECT)
	print("inicio do on ready do main phases")
	tween = create_tween()
	fade_out()
	print(phases.size())
	print(phases)
	var x:int = 0
	for phase_key in DataSystem.DATA_OBJECT["phases"]:
		var phase = phases[phase_key]
		if phase["unlocked"]:
			var button = Button.new()
			add_child(button)
			button.pressed.connect(_set_button_phase_path.bind(phase["path"]))
			button.text = phase["name"]
			button.position = Vector2(200 + x%5,200 + x/5)
			if phase["secret_completed"]:
				button.modulate = Color.REBECCA_PURPLE
			elif  phase["completed"]:
				button.modulate = Color.DARK_GREEN
		x += 1
		print(phase)

func _set_button_phase_path(path:String):
	get_tree().change_scene_to_file(path)

func go_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func fade_in():
	fade_trasition.color = Color(0,0,0,0)
	fade_trasition.show()
	tween = create_tween()
	tween.tween_property(fade_trasition,"color",Color(0,0,0,1),0.3)
	
func fade_out():
	fade_trasition.color = Color(0,0,0,1)
	tween.tween_property(fade_trasition,"color",Color(0,0,0,0),0.3)
	tween.tween_property(fade_trasition,"visible",false,0.2)

func reset_phases():
	for phases_key in DataSystem.DATA_OBJECT["phases"]:
		DataSystem.DATA_OBJECT["phases"][phases_key]["completed"] = false
		DataSystem.DATA_OBJECT["phases"][phases_key]["secret_completed"] = false
		if phases_key != "phase_01":
			DataSystem.DATA_OBJECT["phases"][phases_key]["unlocked"] = false
	DataSystem._save()
	_ready()
func _on_back_button_pressed() -> void:
	fade_in()
	tween.tween_callback(go_to_main_menu)


func _on_reset_phases_button_pressed() -> void:
	reset_phases()
