extends CanvasLayer
class_name ObjectDiscovery

@onready var exits_container: VBoxContainer = $Container/HBoxContainer/ExitsContainer
@onready var points_container: VBoxContainer = $Container/HBoxContainer/PointsContainer


var exits: Dictionary = {}
var points: Dictionary = {}
var exit_item_preload = preload("res://scenes/hud/exit_item_hud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_exit(exit:Exit):
	if exits.has(exit) and exits[exit]["opened"] == exit.opened:
		return
	exits[exit] = {"goal":exit.goal,"opened":exit.opened,"color_opened":exit.color_opened,"color_closed":exit.color_closed}
	update_hud()

func update_exit(exit:Exit):
	if exits.has(exit):
		exits[exit] = {"goal":exit.goal,"opened":exit.opened,"color_opened":exit.color_opened,"color_closed":exit.color_closed}
		update_hud()
	
func add_point(point:Point):
	if points.has(point) and points[point]["pressed"] == point.is_pressed:
		return
	points[point] = {"value":point.value,"pressed":point.is_pressed,"color_pressed":point.color_pressed,"color_unpressed":point.color_unpressed}
	update_hud()

func clear_hud():
	exits.clear()
	points.clear()
	update_hud()
	
	
func update_hud():
	for i in exits_container.get_children():
		exits_container.remove_child(i)
	for i in points_container.get_children():
		points_container.remove_child(i)
	var j = 0;
	for i in exits:
		var exit_item:ExitItemHud = exit_item_preload.instantiate()
		exits_container.add_child(exit_item)
		exit_item.value.text = str(exits[i]["goal"])
		exit_item.enabled.color = exits[i]["color_opened"] if exits[i]["opened"] else exits[i]["color_closed"]
		exit_item.position = Vector2(20,20+45*(j))
		exit_item.value.add_theme_color_override("font_color",exit_item.enabled.color)
		j +=1
	
	j = 0
	for i in points:
		var point_item:ExitItemHud = exit_item_preload.instantiate()
		points_container.add_child(point_item)
		point_item.value.text = str(points[i]["value"])
		point_item.enabled.color = points[i]["color_pressed"] if points[i]["pressed"] else points[i]["color_unpressed"]
		point_item.position = Vector2(120,20+45*(j))
		point_item.value.add_theme_color_override("font_color",point_item.enabled.color)
		j +=1
