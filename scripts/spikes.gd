class_name Spikes extends HurtableNode2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage.position_respawn = respawn
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == null: return
	if body is not Human:
		return
	var human:Human = body
	if human.global_position.y <=  global_position.y:
		damage.hit_jump = true
	if global_position.x < respawn.global_position.x:
		damage.orientation = -1
	else:
		damage.orientation = 1
	human.set_hurtable_node(self)
	human.hit_damage(damage,respawn)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is not Human:
		return
	var human:Human = body
	human.remove_hurtable_node(self)
