class_name Congratulations
extends Control

@onready var timer_to_main_menu: Timer = $timer_to_main_menu

func _ready() -> void:
	timer_to_main_menu.start()
	GlobalHud.ingame_menu_visibility = false
	GlobalHud.help_button.visible = false
	
func _on_timer_to_main_menu_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_screens/main_menu_screen.tscn")
