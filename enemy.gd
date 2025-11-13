extends RigidBody2D


var health = 100
var player

func _physics_process(delta):
	if (player != null):
		pass
	

func damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
