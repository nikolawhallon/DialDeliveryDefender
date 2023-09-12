extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -80.0

var gravity = 200.0
var platforming = false

func _physics_process(delta):
	if not is_on_floor() and platforming:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and platforming:
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0

	if not platforming:
		if Input.is_action_pressed("move_up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("move_down"):
			velocity.y = SPEED
		else:
			velocity.y = 0
	else:
		if Input.is_action_pressed("move_down") and is_on_floor():
			position.y += 1

	move_and_slide()

	if position.y > 120.0 - 10.0 and platforming == true:
		platforming = false
	elif position.y <= 120.0 - 10.0 and platforming == false:
		platforming = true
		# this is kind of a hack
		velocity.y = 0
