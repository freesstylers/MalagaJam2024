class_name MainChar
extends CharacterBody3D

@onready var animation : AnimatedSprite3D = $AnimatedSprite3D

@export var minSpeed = 2.0
@export var maxSpeed = 14.0
@export var minAcceleration : float = 5.0
@export var maxAcceleration : float = 20.0
var acceleration : float = 10.0

# Variable que controla cuanto tarda en cambiar de dirección
# -1 para full borracho, -20 para full ebrio
@export var minDrift : float = -1.0
@export var maxDrift : float = -20.0
var drift : float = -5.0

@export var limits : float = 5.0

var speed = 0.0
var target_velocity = Vector3.ZERO
var direction : Vector3 = Vector3.ZERO
var changingDir : bool = false
var player_velocity : float = 0
var can_move: bool = true
	
func _ready():
	Globals.get_ready_to_run.connect(on_get_ready_to_run)
	Globals.end_game.connect(on_end_game)
	animation.play()
	
func on_get_ready_to_run(drunk_meter):
	acceleration = minAcceleration + (maxAcceleration-minAcceleration)*drunk_meter
	drift = maxDrift + (minDrift-maxDrift)*drunk_meter
	player_velocity = 0
	can_move = true

func on_end_game():
	can_move = false
	
func _physics_process(delta):
	var isMoving = 0
	var prevdir = direction.x
	
	#Bloqueamos el movimiento cuando terminamos partida
	if not can_move:
		return
	
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
		
func set_animation_speed(real_speed):
	animation.speed_scale = 0.25 + 0.75*(real_speed/(Globals.MAX_RUNNING_VEL-Globals.MIN_RUNNING_VEL))
	player_velocity = real_speed
