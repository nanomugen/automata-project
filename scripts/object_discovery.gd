extends CanvasLayer
class_name ObjectDiscovery

@onready var exits_container: VBoxContainer = $Control/Container/HBoxContainer/ExitsContainer
@onready var points_container: VBoxContainer = $Control/Container/HBoxContainer/PointsContainer


var exit_item_hud = preload("res://scenes/hud/exit_item_hud.tscn")
var point_item_hud = preload("res://scenes/hud/point_item_hud.tscn")
var current_state:State

func _ready() -> void:
	
	pass
func _process(_delta: float) -> void:
	pass

func state_transition(state:State):
	print("state_transition")
	clear_hud()
	current_state = state
	setExits(current_state.exits)
	setPoints(current_state.points)

func setExits(exit_array:Array[Exit])->void:
	print("### exit arrays size: ",exit_array.size())
	for i in exit_array:
		print("i in exit_array: ",i)
		var exit = i
		var exitItemHud:ExitItemHud = exit_item_hud.instantiate()
		exitItemHud.exit = exit
		exitItemHud.update_exititemhud()
		exits_container.add_child(exitItemHud)
		exit.on_entered_exit_update_exititemhud_signal.connect(update_exit)
		
		
		

func setPoints(point_array:Array[Point])->void:
	for i in point_array:
		var point = i
		var pointItemHud:PointItemHud = point_item_hud.instantiate()
		pointItemHud.point = point
		pointItemHud.update_pointitemhud()
		points_container.add_child(pointItemHud)
		point.on_entered_point_update_pointitemhud_signal.connect(update_point)

func update_exit(exit:Exit):
	print("$$$$$$ update_exit")
	for i in exits_container.get_children():
		if i is ExitItemHud:
			var exititemhud:ExitItemHud = i
			if exititemhud.exit == exit:
				exititemhud.update_exititemhud()
	

func update_point(point:Point):
	for i in points_container.get_children():
		if i is PointItemHud:
			var pointitemhud:PointItemHud = i
			if pointitemhud.point == point:
				pointitemhud.update_pointitemhud()
				
func clear_hud():
	for exit in exits_container.get_children():
		var exithud:ExitItemHud = exit
		exithud.exit.on_entered_exit_update_exititemhud_signal.disconnect(update_exit)
		exit.queue_free()
	for point in points_container.get_children():
		var pointhud:PointItemHud = point
		pointhud.point.on_entered_point_update_pointitemhud_signal.disconnect(update_point)
		point.queue_free()
	
func update_hud():
	pass
