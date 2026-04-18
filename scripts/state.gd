class_name State
extends Node2D

#@onready var init: Area2D = $INIT
@export var init:Init
@export var points:Array[Point]
@export var exits:Array[Exit]
@export var human: Human

var initPos:Vector2; 
var current_value:float = 0.0
var this_is_current_state:bool = false
func _ready() -> void:
	initPos = init.position;
	#print("init: " + str(initPos))
func _process(delta: float) -> void:
	#print(human.get_node("Camera2D").global_position)
	
	if Input.is_action_just_pressed("attack") and this_is_current_state:
		print("a")
		check_exits()
		update_points()
		


func update_points()->void:
	print("b")
	var filtered_points:Array[Point] = points.filter((func(p): return p.inside_area == true))
	if filtered_points.size() > 0:
		filtered_points[0].pressed()
		if filtered_points[0].is_pressed:
			current_value += filtered_points[0].value
		else:
			current_value -= filtered_points[0].value
		print("value: " + str(current_value))
		update_exits()

func update_exits()->void:
	for e in exits:
		e.update_opened(current_value)

func check_inside_area(exit:Exit):
	print("exit.inside_area: " +str(exit.inside_area))
	return exit.inside_area == true
func check_exits()->void:
	print("check_exits")
	var filtered_exits:Array[Exit] = exits.filter(check_inside_area) 
	print("size filtered exits: " + str(filtered_exits.size()))
	if filtered_exits.size() > 0:
		if filtered_exits[0].goal == current_value:
			transition_next_state(filtered_exits[0])

func transition_next_state(exit:Exit)->void:
	print(exit.is_final)
	if exit.is_final :
		FileSystem.save_data["test_value"] += 1
		FileSystem._save()
		get_tree().change_scene_to_file("res://scenes/congratulations.tscn")
	if exit.nextState == null:
		return
	print("goal == current_value")
	for p in points:
		p.reset_button()
	for e in exits:
		e.reset_exit()
	current_value = 0.0
	var pos:Vector2 = exit.nextState.initPos + exit.nextState.position;
	this_is_current_state = false
	exit.nextState.this_is_current_state = true
	
	var transition_camera:Camera2D = human.get_node("Camera2D")
	transition_camera.reparent(human.get_parent())
	transition_camera.position_smoothing_enabled = false
	
	human.position = pos
	human.freeze = true
	var tween = create_tween()
	
	var pp1 = self.global_position + Vector2(0,-1000)
	var pp2 = exit.nextState.global_position+Vector2(0,-1000)
	var pp3 = human.global_position
	
	tween.tween_property(transition_camera,"global_position",pp1,1)
	tween.parallel().tween_property(transition_camera,"zoom",Vector2(0.3,0.3),1)
	tween.tween_property(transition_camera,"global_position",pp2,1)
	tween.tween_property(transition_camera,"global_position",human.global_position,1)
	tween.parallel().tween_property(transition_camera,"zoom",Vector2(1,1),1)
	tween.tween_callback(transition_camera.reparent.bind(human))
	tween.tween_property(human,"freeze",false,0)
	tween.tween_property(transition_camera,"position",Vector2(0,0),1)
	tween.tween_property(transition_camera,"position_smoothing_enabled",true,0)
	
