class_name PlayerHud
extends CanvasLayer


#@onready var buttons_tutorial: Control = $buttons_tutorial
@onready var menu_button: KeyButton = $menu_button
@onready var fade_transition: ColorRect = $fade_transition
@onready var fps: Label = $PanelContainer/HBoxContainer/left_menu_container/fps
signal call_transition
var tween:Tween

var ingame_menu_visibility = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_transition.connect(fade_in_out)
	fade_transition.visible = false
#	buttons_tutorial.visible = false

func _process(_delta: float) -> void:
	fps.text = str(Engine.get_frames_per_second())
	if Input.is_action_just_pressed("ingame_menu") and ingame_menu_visibility:
		if DataSystem.DATA_OBJECT["show_tutorial"]:
#			buttons_tutorial.visible = !buttons_tutorial.visible 
			menu_button.visible = !menu_button.visible
			




func _on_back_to_menu_button_pressed() -> void:
#	buttons_tutorial.visible = false
	ingame_menu_visibility = false
	
	fade_in()
	tween.tween_callback(go_to_main_menu)
	fade_out()
	
func go_to_main_menu():
	print("go_to_main_menu")
	get_tree().change_scene_to_file("res://scenes/menu_screens/main_menu_screen.tscn")
	
func fade_in():
	fade_transition.color = Color(0,0,0,0)
	fade_transition.show()
	tween = create_tween()
	tween.tween_property(fade_transition,"color",Color(0,0,0,1),0.3)

func fade_out():
	fade_transition.color = Color(0,0,0,1)
	tween.tween_property(fade_transition,"color",Color(0,0,0,0),0.3)
	tween.tween_property(fade_transition,"visible",false,0.2)
	
func fade_in_out(time:float,mid_signal:Signal):
	tween = create_tween()
	fade_transition.color = Color(0,0,0,0)
	fade_transition.show()
	tween.tween_property(fade_transition,"color",Color(0,0,0,1),time/4)
	
	tween.tween_callback(func(): 
		
		print("inside the emit")
		mid_signal.emit()
		)
	tween.tween_property(fade_transition,"tooltip_text"," ",time/2)
	tween.tween_property(fade_transition,"color",Color(0,0,0,0),time/4)
	tween.tween_property(fade_transition,"visible",false,0.0)
	
