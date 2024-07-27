extends CharacterBody3D

@export var maxSpeed = 14.0
@export var acceleration : float = 1.0

# Variable que controla cuanto tarda en cambiar de dirección
# -1 para full borracho, -20 para full ebrio
@export var drift : float = -20.0

@export var limits : float = 5.0

var speed = 0.0
var target_velocity = Vector3.ZERO
var direction : Vector3 = Vector3.ZERO
var changingDir : bool = false
	
func _physics_process(delta):
	var isMoving = 0
	var prevdir = direction.x

	if not changingDir:
		if Input.is_action_pressed("RIGHT"):
			direction.x = 1
			isMoving = 1
		elif Input.is_action_pressed("LEFT"):
			direction.x = -1
			isMoving = 1
		else:
			isMoving = -1
		
	# Si esta cambiando de direción
	if (velocity.x * direction.x) < 0 and not changingDir:
		changingDir = true
		direction.x = prevdir
		
	if changingDir:
		speed += acceleration * delta * drift
		if speed < 0.1:
			changingDir = false
	else:
		speed += acceleration * delta * isMoving
	
		
	if speed > maxSpeed:
		speed = maxSpeed
	if speed < 0.0:
		speed = 0.0

	target_velocity.x = direction.x * speed

	velocity = target_velocity
	if position.x < limits and direction.x > 0 or position.x > -limits and direction.x < 0:
		move_and_slide()
	else:
		velocity = Vector3.ZERO
		speed = 0
