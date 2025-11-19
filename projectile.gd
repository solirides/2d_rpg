extends RigidBody2D

func _on_body_entered(body: Node) -> void:
	# just for debugging
	print("projectile collided")
	# if the body is an enemy, damage it then delete the projectile
	if body.is_in_group("enemy"):
		body.damage(20)
		queue_free()
	
	# if the body is a wall (a physics body in layer 3),
	# delete the projectile
	if body.get_collision_layer_value(3):
		queue_free()
