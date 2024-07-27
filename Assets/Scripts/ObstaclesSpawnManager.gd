class_name ObstaclesSpawnManager
extends Node

@export var CentralPositionNode : Node3D = null
@export var RightPositionNode : Node3D = null
@export var LeftPositionNode : Node3D = null

@export var One_Slot_Static_Prefabs : Array[PackedScene] = []
@export var Two_Slot_Static_Prefabs : Array[PackedScene] = []
@export var One_Slot_Moving_Prefabs : Array[PackedScene] = []
@export var One_Static_One_Moving_Prefabs : Array[PackedScene] = []
@export var Two_Slot_Moving_Prefabs : Array[PackedScene] = []

var meters_till_next_obstacle : float = 0
var meters_per_obstacle : float = 700

enum ObstacleType { ONE_SLOT_STATIC = 0, TWO_SLOT_STATIC, ONE_SLOT_MOVING, ONE_STATIC_ONE_MOVE, TWO_SLOT_MOVE, OBSTACLE_TYPE_MAX }

func _ready():
	Globals.get_ready_to_run.connect(on_get_ready_to_run)

func PlayerIsRunning(player_velocity):
	meters_till_next_obstacle  = meters_till_next_obstacle - player_velocity
	if meters_till_next_obstacle < 0:
		SpawnObstacleScreen()	

func SpawnObstacleScreen():
	meters_till_next_obstacle = meters_per_obstacle
	var new_screen_type = ObstacleType.ONE_SLOT_MOVING#randi() % ObstacleType.OBSTACLE_TYPE_MAX
	match new_screen_type:
		ObstacleType.ONE_SLOT_STATIC:
			#Get a random obstacle
			var new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
			var random_pos : Vector3 = Vector3(random_pos_index_to_vector(randi()%3).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(random_pos)
		ObstacleType.TWO_SLOT_STATIC:
			#Get a random position
			var random_index_1 = 1
			var random_index_2 = randi()%3
			while random_index_1 == random_index_2:
				random_index_2 = randi()%3
			#Get an obstacle to spawn
			var new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
			var random_pos_1 : Vector3 = Vector3(random_pos_index_to_vector(random_index_1).x, new_obstacle.position.y,new_obstacle.position.z)
			var random_pos_2 : Vector3 = Vector3(random_pos_index_to_vector(random_index_2).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement((random_pos_1+random_pos_2)/2)
			pass
		ObstacleType.ONE_SLOT_MOVING:
			#Get a random position
			var random_index_1 = 1
			var random_index_2 = randi()%3
			while random_index_1 == random_index_2:
				random_index_2 = randi()%3
			#Get an obstacle to spawn
			var new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
			var random_pos_1 : Vector3 = Vector3(random_pos_index_to_vector(random_index_1).x, new_obstacle.position.y,new_obstacle.position.z)
			var random_pos_2 : Vector3 = Vector3(random_pos_index_to_vector(random_index_2).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(random_pos_1, random_pos_2, 0.5)
		ObstacleType.ONE_STATIC_ONE_MOVE:
			#Get a random position
			var random_index_1 = randi()%3
			var random_index_2 = randi()%3
			while random_index_1 == random_index_2:
				random_index_2 = randi()%3
			#Get an obstacle to spawn
			var new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
			var random_pos_1 : Vector3 = Vector3(random_pos_index_to_vector(random_index_1).x, new_obstacle.position.y,new_obstacle.position.z)
			var random_pos_2 : Vector3 = Vector3(random_pos_index_to_vector(random_index_2).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(random_pos_1, random_pos_2)
		ObstacleType.TWO_SLOT_MOVE:
			var x_pos_1 = (LeftPositionNode.position.x + CentralPositionNode.position.x) / 2 
			var x_pos_2 = (RightPositionNode.position.x + CentralPositionNode.position.x) / 2 
			#Get an obstacle to spawn
			var new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
			var random_pos_1 : Vector3 = Vector3(x_pos_1, new_obstacle.position.y,new_obstacle.position.z)
			var random_pos_2 : Vector3 = Vector3(x_pos_2, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(random_pos_1, random_pos_2)

func on_get_ready_to_run():
	meters_till_next_obstacle = meters_per_obstacle

func random_pos_index_to_vector(index):
	match index:
		0:
			return LeftPositionNode.position 
		1:
			return CentralPositionNode.position
		2:
			return RightPositionNode.position

func instantiate_an_obstacle(obstacles_array):
	var random_obstacle_index = randi() % obstacles_array.size()
	var new_obstacle = obstacles_array[random_obstacle_index].instantiate() as Obstacle
	Globals.obstacle_spawned.emit(new_obstacle)
	return new_obstacle
