class_name Phase
extends Node2D
@onready var human: Human = $human
@export var start_state: State;
@onready var test_value: Label = $testValue

@export var phase_name:String


func _ready() -> void:
	PlayerHudControl.ingame_menu_visibility = true
	PlayerHudControl.help_button.visible = true
	var pos:Vector2 = start_state.initPos + start_state.position;
	start_state.this_is_current_state = true
	human.position = pos;
	#test_value.text = "valor de teste: "+str(DataSystem.DATA_OBJECT["test_value"])
	
func _process(_delta: float) -> void:
	pass

func _on_conclude_phase(conclusion_code:String):
	if phase_name == "" or phase_name == null:
		return
	if conclusion_code in ["completed","secret_completed"]:
		DataSystem.DATA_OBJECT["phases"][phase_name][conclusion_code] = true
	else:
		return
	DataSystem._save()
