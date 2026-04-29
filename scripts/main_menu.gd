extends Node2D

@onready var fade_trasition: ColorRect = $fade_trasition

var tween:Tween 
@onready var debug: Button = $button_manager/debug

func _ready():
	debug.visible = false
	print(fade_trasition.get_child(0))
	
	fade_out()
	PlayerHudControl.ingame_menu_visibility = false
	PlayerHudControl.help_button.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("dash") and Input.is_action_pressed("attack"):
		debug.visible = true

func _on_start_pressed() -> void:
	if Input.is_action_pressed("dash") and Input.is_action_pressed("attack"):
		fade_in()
		tween = create_tween()
		tween.tween_callback(go_to_debug)
	else:
		print("on_start_pressed_else")
		fade_in()
		print("after fade_in")
		tween = create_tween()
		tween.tween_callback(go_to_main_phases)
		print("after tween go to main phases")
	
	
func _on_option_pressed() -> void:
	print("on_option_pressed antes do fade in")
	fade_in()
	print("on_option_pressed depois do fade in")
	tween = create_tween()
	tween.tween_callback(go_to_options)

func _on_debug_pressed() -> void:
	fade_in()
	tween = create_tween()
	tween.tween_callback(go_to_debug)
	
func go_to_main_phases():
	DataSystem.DATA_OBJECT["debug_mode"] = false
	print("antes de chamar a arvore e mudar de cena")
	get_tree().change_scene_to_file("res://scenes/menus/main_phases.tscn")
	
func go_to_options():
	print("antes de mudar de scene")
	get_tree().change_scene_to_file("res://scenes/menus/main_options.tscn")

func go_to_tutorial():
	get_tree().change_scene_to_file("res://scenes/phases/phase_tutorial.tscn")

func go_to_debug():
	DataSystem.DATA_OBJECT["debug_mode"] = true
	get_tree().change_scene_to_file("res://scenes/phases/phase_debug.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit();

func fade_in():
	print("fade_in init")
	tween = create_tween()
	fade_trasition.color = Color(0,0,0,0)
	fade_trasition.visible = true
	tween.tween_property(fade_trasition,"color",Color(0,0,0,1),1)
	print("fade_in end")

func fade_out():
	tween = create_tween()
	fade_trasition.color = Color(0,0,0,1)
	tween.tween_property(fade_trasition,"color",Color(0,0,0,0),0.3)
	tween.tween_property(fade_trasition,"visible",false,0)


func _on_tutorial_pressed() -> void:
	fade_in()
	tween.tween_callback(go_to_tutorial)
