class_name Phase
extends Node2D
@onready var human: Human = $human
@export var start_state: State;
@onready var test_value: Label = $testValue

func _ready() -> void:
	PlayerHudControl.ingame_menu_visibility = true
	PlayerHudControl.help_button.visible = true
	var pos:Vector2 = start_state.initPos + start_state.position;
	start_state.this_is_current_state = true
	human.position = pos;
	#test_value.text = "valor de teste: "+str(DataSystem.DATA_OBJECT["test_value"])
	
func _process(_delta: float) -> void:
	pass
