class_name PlayerHud
extends CanvasLayer

@onready var exits_label: Label = $Control/exits_label
@onready var points_label: Label = $Control/points_label
@onready var exit_items: ItemList = $Control/exit_items
@onready var discovery: Control = $Discovery

var exit_item_preload = preload("res://scenes/hud/exit_item_hud.tscn")

var exits: Dictionary = {}
var points: Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func add_exit(exit:Exit):
	print("adding exit: " + str(exit))
	exits[exit] = {"goal":exit.goal,"opened":exit.opened,"color_opened":exit.color_opened,"color_closed":exit.color_closed}
	update_hud()
	print(exits)

func update_exit(exit:Exit):
	if exits.has(exit):
		exits[exit] = {"goal":exit.goal,"opened":exit.opened,"color_opened":exit.color_opened,"color_closed":exit.color_closed}
		update_hud()
	
func add_point(point:Point):
	points[point] = {"value":point.value,"pressed":point.is_pressed,"color_pressed":point.color_pressed,"color_unpressed":point.color_unpressed}
	update_hud()

func clear_hud():
	exits.clear()
	points.clear()
	update_hud()
	
	
func update_hud():
	var exits_str = ""
	#exit_items.clear()
	for i in discovery.get_children():
		discovery.remove_child(i)
	var j = 0;
	for i in exits:
		var exit_item:ExitItemHud = exit_item_preload.instantiate()
		discovery.add_child(exit_item)
		exit_item.value.text = str(exits[i]["goal"])
		exit_item.enabled.color = exits[i]["color_opened"] if exits[i]["opened"] else exits[i]["color_closed"]
		exit_item.position = Vector2(10,25*(j))
		exit_item.value.add_theme_color_override("font_color",exit_item.enabled.color)
		j +=1
		#exits_str += str(exits[i]["goal"]) + " " + str(exits[i]["opened"]) +"\n"
	#exits_label.text = exits_str
	
	
	var points_str = ""
	j = 0
	for i in points:
		var point_item:ExitItemHud = exit_item_preload.instantiate()
		discovery.add_child(point_item)
		point_item.value.text = str(points[i]["value"])
		point_item.enabled.color = points[i]["color_pressed"] if points[i]["pressed"] else points[i]["color_unpressed"]
		point_item.position = Vector2(70,25*(j))
		point_item.value.add_theme_color_override("font_color",point_item.enabled.color)
		j +=1
		
		points_str += str(points[i]["value"]) + " " + str(points[i]["pressed"]) +"\n"
	points_label.text = points_str
