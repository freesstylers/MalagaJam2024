class_name Obstacle
extends Node3D

@export var Moving_Thing : Sprite3D = null
@export var Moving_Thing_Shadow : Sprite3D = null

@export var Min_Vel_Reduction : float = 100
@export var Max_Vel_Reduction : float = 100

@export var Spawn_Pos : Vector3 = Vector3.ZERO
@export var Dest_pos : Vector3 = Vector3.ZERO
@export var Movement_Delay : float = 0
@export var Loop_Back : bool = true
@export var Movement_Duration : float = 1.0

var player_vel : float = 0

func _ready():
	Moving_Thing.modulate.a = 0
	Moving_Thing_Shadow.modulate.a = 0
	var local_tween = create_tween().set_parallel(true) 
	local_tween.tween_property(Moving_Thing,"modulate:a", 1 , 0.2)
	local_tween.tween_property(Moving_Thing_Shadow,"modulate:a", 1 , 0.2)

func _exit_tree():
	Globals.obstacle_avoided.emit()

func on_body_entered(other_body):
	if other_body.is_in_group("PLAYER"):
		var vel_reduction_factor : float = (player_vel-Globals.MIN_RUNNING_VEL) / (Globals.MAX_RUNNING_VEL-Globals.MIN_RUNNING_VEL)
		var vel_reduction : float = Min_Vel_Reduction + (vel_reduction_factor * (Max_Vel_Reduction-Min_Vel_Reduction))
		Globals.obstacle_hit.emit(vel_reduction)

func program_movement(s_pos = Vector3.ZERO, d_pos = Vector3.ZERO, duration = 1.0, delay = 0, loop = true):
	Moving_Thing.position = s_pos
	Moving_Thing_Shadow.position.x = s_pos.x
	Loop_Back = loop 
	if (s_pos == d_pos):
		return
	var local_tween = Moving_Thing.create_tween()
	local_tween.set_parallel(true)
	local_tween.tween_property(Moving_Thing, "position", d_pos, duration).set_delay(delay)
	local_tween.tween_property(Moving_Thing_Shadow, "position:x", d_pos.x, duration).set_delay(delay)
	local_tween.chain().tween_callback(func():
		if Loop_Back:
			program_movement(d_pos, s_pos, duration,delay, Loop_Back)
		)

func set_player_vel(vel):
	player_vel = vel
