class_name RoadManager
extends Node

@export var RoadObjects : Array[PathFollow3D] = []

func _ready():
	Globals.obstacle_spawned.connect(on_obstacle_spawned)

func PlayerIsRunning(player_velocity):
	var start = RoadObjects.size() - 1
	for object_index in range(start,-1,-1):
		var ratio_delta = player_velocity / (Globals.MAX_RUNNING_VEL-Globals.MIN_RUNNING_VEL)
		var end_ratio = RoadObjects[object_index].progress_ratio + ratio_delta
		#Obstacle
		if end_ratio > 1.0:
			var aux = RoadObjects[object_index]
			RoadObjects.remove_at(object_index)
			aux.queue_free()
		else:
			RoadObjects[object_index].progress_ratio += ratio_delta

func on_obstacle_spawned(new_obstacle):
	var pathF3D = PathFollow3D.new()
	add_child(pathF3D)
	pathF3D.progress_ratio = 0
	pathF3D.add_child(new_obstacle)
	RoadObjects.append(pathF3D)

func clear_obstacles():
	RoadObjects.clear()
	var children = get_children()
	for child_index in range(children.size()):
		(children[child_index] as Node).queue_free()
