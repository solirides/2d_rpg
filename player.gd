extends CharacterBody2D

@export var speed = 200
@export var health = 100

var dir = "right"
var moving = false

var projectile = preload("res://projectile.tscn")
var enemy = preload("res://enemy.tscn")

func _physics_process(delta):
	#### movement ####
	# get input and move the player
	velocity = Input.get_vector("left", "right", "up", "down")
	velocity *= speed
	move_and_slide()
	
	#### animation ####
	moving = false
	var suffix = "_idle" # these strings should match the animation names
	# select the correct animation for the movement direction
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
	
	#### inputs ####
	if Input.is_action_just_pressed("fire"):
		# create an instance of the projectile
		var instance = projectile.instantiate()
		# set position, rotation, and velocity based on cursor
		var direction = get_global_mouse_position() - self.position
		direction = direction.normalized()
		instance.global_position = self.global_position
		instance.rotation = atan2(direction.y, direction.x)
		instance.linear_velocity = direction * 500
		# add the instance to the scene
		get_tree().get_current_scene().add_child(instance)
	
	if Input.is_action_just_pressed("summon"):
		# create an instance of the enemy and place it at the cursor
		var instance = enemy.instantiate()
		instance.global_position = get_global_mouse_position()
		# set the "target" variable to the player
		instance.target = self
		# add the instance to the scene
		get_tree().get_current_scene().add_child(instance)

# same function as the one in enemy.gd
func damage(amount):
	modulate = Color(1,0,0)
	create_tween().tween_property(self, "modulate", Color(1,1,1), 0.4)
	health -= amount
	if health <= 0:
		print("you died!")
		# show the game over screen
		$GameOver.visible = true

func revive():
	$GameOver.visible = false
	health = 100
