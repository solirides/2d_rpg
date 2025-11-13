extends RigidBody2D

func _on_body_entered(body: Node) -> void:
	print("collide")
	if body.is_in_group("enemy"):
		body.damage(20)
		queue_free()
	if (body.collision_layer & (100)) != 0: # hit wall
		queue_free()
