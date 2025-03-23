extends CharacterBody2D

@export var speed = 200

var dir = "right"
var moving = false

var projectile = preload("res://projectile.tscn")

func _physics_process(delta):
	
	# get input and move the player
	velocity = Input.get_vector("left", "right", "up", "down")
	velocity *= speed
	move_and_slide()
	
	
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
	
	
	if Input.is_action_just_pressed("fire"):
		# create an instance of the projectile
		var instance = projectile.instantiate()
		var direction = get_global_mouse_position() - self.position
		direction = direction.normalized()
		instance.global_position = self.global_position
		instance.rotation = atan2(direction.y, direction.x)
		instance.linear_velocity = direction * 500
		# add the instance to the scene
		get_tree().get_current_scene().add_child(instance)
	
