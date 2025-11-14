extends RigidBody2D


var health = 100
@export var player:Node
@export var speed = 200

func _physics_process(delta):
	if (player != null):
		var dist = player.global_position - self.global_position
		linear_velocity += dist.normalized() * speed * delta
	

func damage(amount):
	modulate = Color(1,0,0)
	create_tween().tween_property(self, "modulate", Color(1,1,1), 0.4)
	health -= amount
	if health <= 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(20)
