extends CharacterBody2D

var door = 0
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500.0
var walk_direction = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Movimiento Y del jugador
	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.y >= 500 :
		velocity.y = 500
	
	# Saltar
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# El movimiento X del jugador
	var direction = Input.get_axis("ui_left", "ui_right")
	#if direction :
	velocity.x = direction * SPEED
	if direction < 0 :
		walk_direction = false
	elif direction > 0 :
		walk_direction = true
	
	# Define los Sprites
	if direction and is_on_floor():
		if direction < 0 :
			$AnimetedSprite.play("left_walk")
			walk_direction = false
		elif direction > 0 :
			$AnimetedSprite.play("right_walk")
			walk_direction = true
	elif is_on_floor() :
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not walk_direction :
			$AnimetedSprite.play("left_stop")
		else :
			$AnimetedSprite.play("right_stop")
	
	if  velocity.y  < 0 and not is_on_floor() :
		if walk_direction :
			$AnimetedSprite.play("right_jump")
		elif not walk_direction :
			$AnimetedSprite.play("left_jump")
	elif velocity.y > 0 and not is_on_floor() :
		if walk_direction :
			$AnimetedSprite.play("right_fall")
		elif not walk_direction :
			$AnimetedSprite.play("left_fall")
	
	
	#Funcion de las puertas
	
	if door == 1  and Input.is_action_just_pressed("ui_down"):
		get_tree().quit()
	
	move_and_slide()
	


func _on_hermitan_house_area_entered(area):
	door = 1
