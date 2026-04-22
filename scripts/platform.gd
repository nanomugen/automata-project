extends Node2D

@onready var h_reference: ColorRect = $StaticBody2D/h_reference

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !DataSystem.DATA_OBJECT["debug_mode"]:
		h_reference.visible = false
		pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
