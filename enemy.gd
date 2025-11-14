extends RigidBody2D

@export var speed = 200
@export var health = 100
# the node to follow and attack (the player)
@export var target:Node

var attack_ready = true

func _physics_process(delta):
	# move towards the target
	if (target != null):
		var dist = target.global_position - self.global_position
		linear_velocity += dist.normalized() * speed * delta
	
	# handle attacks
	try_attack()

func try_attack():
	# stop the attack if the cooldown isn't over
	if attack_ready == false:
		return
	# loop through all bodies inside the attack range
	for body in $Area2D.get_overlapping_bodies():
		# if the body is a player, damage it
		if body.is_in_group("player"):
			body.damage(20)
			# start the attack cooldown
			attack_ready = false
			$Timer.start()
	

func damage(amount):
	# animate the damage flash
	modulate = Color(1,0,0)
	create_tween().tween_property(self, "modulate", Color(1,1,1), 0.4)
	
	health -= amount
	if health <= 0:
		# delete the node if its health reaches 0
		queue_free()

func _on_timer_timeout() -> void:
	# end the attack cooldown
	attack_ready = true
