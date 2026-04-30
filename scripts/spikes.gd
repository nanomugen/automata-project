extends Node2D

@onready var damage: Damage = $damage
@export var respawn:RespawnSpot;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("encostou no spike")
	if body is not Human:
		return
	var human:Human = body
	human.hit_damage(damage,respawn)
