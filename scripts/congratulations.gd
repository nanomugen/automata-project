class_name Congratulations
extends Control

@onready var timer_to_main_menu: Timer = $timer_to_main_menu

func _ready() -> void:
	timer_to_main_menu.start()
func _on_timer_to_main_menu_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
