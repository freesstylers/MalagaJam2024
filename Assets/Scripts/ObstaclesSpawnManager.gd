class_name ObstaclesSpawnManager
extends Node

@export var ObstaclePrefab : PackedScene = null
var meters_till_next_obstacle : float = 0
var meters_per_obstacle : float = 700

func _ready():
	Globals.get_ready_to_run.connect(on_get_ready_to_run)

func PlayerIsRunning(player_velocity):
	meters_till_next_obstacle  = meters_till_next_obstacle - player_velocity
	if meters_till_next_obstacle < 0:
		SpawnObstacle()	

func SpawnObstacle():
	meters_till_next_obstacle = meters_per_obstacle
	var new_obstacle = ObstaclePrefab.instantiate()
	Globals.obstacle_spawned.emit(new_obstacle)

func on_get_ready_to_run():
	meters_till_next_obstacle = meters_per_obstacle
