extends CanvasLayer
class_name ObjectDiscovery

@onready var exits_container: VBoxContainer = $Container/HBoxContainer/ExitsContainer
@onready var points_container: VBoxContainer = $Container/HBoxContainer/PointsContainer

var exit_item_hud = preload("res://scenes/hud/exit_item_hud.tscn")
var point_item_hud = preload("res://scenes/hud/point_item_hud.tscn")

var exits: Array[Exit]
var points: Array[Point]

func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	pass

func setExits(exit_array:Array[Exit])->void:
	exits = exit_array
	for i in exit_array:
		var exit:ExitItemHud = exit_item_hud.instantiate()
		#exit.
		

func setPoints(point_array:Array[Point])->void:
	points = point_array	

func update_exit(exit:Exit):
	pass

func update_point(point:Point):
	pass
func clear_hud():

	update_hud()
	
	
func update_hud():
	pass
