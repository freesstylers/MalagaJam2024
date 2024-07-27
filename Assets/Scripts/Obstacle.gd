class_name Obstacle
extends Node3D

@export var Moving_Thing : Node3D = self
@export var Moving_Thing_Shadow : Node3D = self
@export var Points_When_Evaded : int = 50
@export var Vel_Reduction : float = 100

@export var Spawn_Pos : Vector3 = Vector3.ZERO
@export var Dest_pos : Vector3 = Vector3.ZERO
@export var Movement_Delay : float = 0
@export var Loop_Back : bool = true
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
