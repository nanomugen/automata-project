extends Node2D
var comment = """"
@onready var human: Human = $human
@export var start_state: State;
@onready var test_value: Label = $testValue

func _ready() -> void:
	var pos:Vector2 = start_state.initPos + start_state.position;
	start_state.this_is_current_state = true
	human.position = pos;
	test_value.text = "valor de teste: "+str(FileSystem.save_data["test_value"])
	
func _process(delta: float) -> void:
	pass
"""
