class_name State
extends Node2D

#@onready var init: Area2D = $INIT
@export var init:Init
@export var points:Array[Point]
@export var exits:Array[Exit]
@export var doors:Array[Door]
@export var human: Human

var initPos:Vector2; 
var current_value:int = 0
var this_is_current_state:bool = false
func _ready() -> void:
	initPos = init.position;
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("attack") and this_is_current_state:
		check_doors()
		check_exits()
		update_points()
		
func check_doors():
	var door_to_verify:Array[Door]
	var button_to_press:DoorButton
	for d in doors:
		var filtered_buttons:Array[DoorButton] = d.buttons.filter((func(b): return b.inside_area == true))
		if filtered_buttons.size() > 0:
			door_to_verify.append(d)
			button_to_press = filtered_buttons[0]
			print("d")
			#filtered_buttons[0].pressed()
			#d.verify_buttons()
	if door_to_verify.size() > 0:
		print(door_to_verify.size())
		button_to_press.pressed()
		for d2 in door_to_verify:
			d2.verify_buttons()
	

func update_points()->void:
	var filtered_points:Array[Point] = points.filter((func(p): return p.inside_area == true))
	if filtered_points.size() > 0:
		filtered_points[0].pressed()
		if filtered_points[0].is_pressed:
			current_value += filtered_points[0].value
		else:
			current_value -= filtered_points[0].value
		update_exits()

func update_exits()->void:
	for e in exits:
		e.update_opened(current_value)

func check_inside_area(exit:Exit):
	return exit.inside_area == true
func check_exits()->void:
	var filtered_exits:Array[Exit] = exits.filter(check_inside_area) 
	if filtered_exits.size() > 0:
		#if filtered_exits[0].goal == current_value:
		if filtered_exits[0].opened:
			transition_next_state(filtered_exits[0])

func transition_next_state(exit:Exit)->void:
	PlayerHudControl.clear_hud()
	if exit.is_final :
		var completion_code =  "secret_completed" if exit.is_secret else "completed"
		var parent_phase:Phase = get_parent()
		parent_phase._on_conclude_phase(completion_code) 
		#####################
		#isso ta errado, precisa consertar essa lógica, call down, signal up
		get_tree().change_scene_to_file("res://scenes/menus/congratulations.tscn")
	if exit.nextState == null:
		return
	for p in points:
		p.reset_button()
	for e in exits:
		e.reset_exit()
	current_value = 0
	var pos:Vector2 = exit.nextState.initPos + exit.nextState.position;
	this_is_current_state = false
	exit.nextState.this_is_current_state = true
	
	var transition_camera:Camera2D = human.get_node("Camera2D")
	transition_camera.reparent(human.get_parent())
	transition_camera.position_smoothing_enabled = false
	transition_camera.drag_vertical_offset = 0
	
	human.position = pos
	human.freeze = true
	var tween = create_tween()
	
	var pp1 = self.global_position + Vector2(0,-1000)
	var pp2 = exit.nextState.global_position+Vector2(0,-1000)
	
	tween.tween_property(transition_camera,"global_position",pp1,1)
	tween.parallel().tween_property(transition_camera,"zoom",Vector2(0.3,0.3),1)
	tween.tween_property(transition_camera,"global_position",pp2,1)
	tween.tween_property(transition_camera,"global_position",human.global_position,1)
	tween.parallel().tween_property(transition_camera,"zoom",Vector2(1,1),1)
	tween.tween_callback(transition_camera.reparent.bind(human))
	tween.tween_property(human,"freeze",false,0)
	tween.tween_property(transition_camera,"drag_vertical_offset",-1.0,0.5)
	tween.tween_property(transition_camera,"position",Vector2(0,0),1)
	tween.tween_property(transition_camera,"position_smoothing_enabled",true,0)
	
