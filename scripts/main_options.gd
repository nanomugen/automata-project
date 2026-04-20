extends Node2D

@onready var fade_trasition: ColorRect = $fade_trasition

var tween:Tween

func _ready() -> void:
	tween = create_tween()
	fade_out()

func _on_back_button_pressed() -> void:
	fade_in()
	tween.tween_callback(go_to_main_menu)
	
func go_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

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
