extends Node2D

@onready var fade_trasition: ColorRect = $fade_trasition
var tween:Tween 

func _ready():
	print(fade_trasition.get_child(0))
	tween = create_tween()
	fade_out()
	PlayerHudControl.ingame_menu_visibility = false
	PlayerHudControl.help_button.visible = false
func _on_start_pressed() -> void:
	fade_in()
	tween.tween_callback(go_to_main)
	
func _on_option_pressed() -> void:
	fade_in()
	tween.tween_callback(go_to_options)

func _on_debug_pressed() -> void:
	fade_in()
	tween.tween_callback(go_to_debug)
	
func go_to_main():
	get_tree().change_scene_to_file("res://scenes/phases/phase_01.tscn")
	
func go_to_options():
	get_tree().change_scene_to_file("res://scenes/menus/main_options.tscn")

func go_to_debug():
	get_tree().change_scene_to_file("res://scenes/phases/phase_debug.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit();

func fade_in():
	print("inside fade_in")
	fade_trasition.color = Color(0,0,0,0)
	fade_trasition.show()
	tween = create_tween()
	tween.tween_property(fade_trasition,"color",Color(0,0,0,1),0.3)
	print("end of fade_in")
	
	
func fade_out():
	fade_trasition.color = Color(0,0,0,1)
	tween.tween_property(fade_trasition,"color",Color(0,0,0,0),0.3)
	tween.tween_property(fade_trasition,"visible",false,0.2)
