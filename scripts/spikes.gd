extends Node2D

@onready var damage: Damage = $damage
@export var respawn:Node2D;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Human:
		return
	var human:Human = body
	human.hit_damage(damage,respawn)
