extends CharacterBody2D

@export var speed = 200

var dir = "right"
var moving = false

var projectile = preload("res://projectile.tscn")

func _physics_process(delta):
	
	# get input and modify speed
	velocity = Input.get_vector("left", "right", "up", "down")
	velocity *= speed
	
	moving = false
	var suffix = "_idle" # these strings should match the animation names
	if velocity.length() > 0:
		moving = true
		suffix = "_walk"
	
	if velocity.x < 0:
		dir = "left"
	elif velocity.x > 0:
		dir = "right"
	elif velocity.y < 0:
		dir = "up"
	elif velocity.y > 0:
		dir = "down"
		
	var animation = $AnimatedSprite2D
	animation.play(dir + suffix)
	
	move_and_slide()
	
	
	

		#"up":
			#animation.play("side_walk")
		#"down":
			#animation.play("side_walk")
	
	if Input.is_action_just_pressed("fire"):
		var instance = projectile.instantiate()
		
		var direction = get_global_mouse_position() - self.position
		direction = direction.normalized()
		instance.global_position = self.global_position
		instance.rotation = atan2(direction.y, direction.x)
		instance.linear_velocity = direction * 500
		self.get_parent().add_child(instance)
		print("fire")
	

func _input(event):
	pass
	
	
	
