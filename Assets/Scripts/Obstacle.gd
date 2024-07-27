class_name Obstacle
extends Node3D

@export var Moving_Thing : Node3D = self
@export var Points_When_Evaded : int = 100
@export var Vel_Reduction : float = 100

@export var Spawn_Pos : Vector3 = Vector3.ZERO
@export var Dest_pos : Vector3 = Vector3.ZERO
@export var Movement_Delay : float = 0
@export var Loop_Back : bool = false
@export var Movement_Duration : float = 1.0

#func _ready():
	#if Spawn_Pos != Vector3.ZERO or Dest_pos != Vector3.ZERO:
		#program_movement(Spawn_Pos, Dest_pos, Movement_Duration, Movement_Delay)

func _exit_tree():
	Globals.obstacle_avoided.emit(Points_When_Evaded)
	#Globals.obstacle_hit.emit(Vel_Reduction)	

func on_body_entered(other_body):
	if other_body.is_in_group("PLAYER"):
		Globals.obstacle_hit.emit(Vel_Reduction)

func program_movement(s_pos = Vector3.ZERO, d_pos = Vector3.ZERO, duration = 1.0, delay = 0, loop = true):
	Moving_Thing.position = s_pos
	Loop_Back = loop 
	if (s_pos == d_pos) or (s_pos != Vector3.ZERO and d_pos == Vector3.ZERO):
		return
	var local_tween = Moving_Thing.create_tween()
	local_tween.tween_property(Moving_Thing, "position", d_pos, duration).set_delay(delay)
	local_tween.tween_callback(func():
		if Loop_Back:
			program_movement(d_pos, s_pos, duration,delay, Loop_Back)
		)
