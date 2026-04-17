extends Node2D
@onready var human: Human = $human
@export var start_state: State;

func _ready() -> void:
	var pos:Vector2 = start_state.initPos + start_state.position;
	start_state.this_is_current_state = true
	#print("pos no main: " + str(pos));
	human.position = pos;
	
func _process(delta: float) -> void:
	pass
