extends RigidBody2D


var health = 100
@export var player:Node
@export var speed = 200

func _physics_process(delta):
	if (player != null):
		var dist = player.global_position - self.global_position
		
		linear_velocity += dist.normalized() * speed * delta
	

func damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
