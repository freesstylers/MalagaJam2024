class_name ObstaclesSpawnManager
extends Node

@export var CentralPositionNode : Node3D = null
@export var RightPositionNode : Node3D = null
@export var LeftPositionNode : Node3D = null

@export var One_Slot_Static_Prefabs : Array[PackedScene] = []
@export var Two_Slot_Static_Prefabs : Array[PackedScene] = []
@export var One_Slot_Moving_Prefabs : Array[PackedScene] = []
@export var Two_Slot_Moving_Prefabs : Array[PackedScene] = []

@export var min_meters : float = 200.0
@export var max_meters : float = 300.0
var current_min_meters : float = min_meters
var current_max_meters : float = max_meters
var final_min_meters : float = 50.0
var final_max_meters : float = 100.0

@onready var decrease_meters_timer = $DecreaseSpawnMetersTimer

var meters_till_next_obstacle : float = 0
var meters_per_obstacle : float = 300

var game_lost : bool = false

enum ObstacleType { ONE_SLOT_STATIC = 0, TWO_SLOT_STATIC, ONE_SLOT_MOVING, ONE_STATIC_ONE_MOVE, OBSTACLE_TYPE_MAX }

func _ready():
	Globals.get_ready_to_run.connect(on_get_ready_to_run)
	Globals.player_lost.connect(on_game_lost)

func PlayerIsRunning(player_velocity):
	if game_lost:
		return
	meters_till_next_obstacle  = meters_till_next_obstacle - player_velocity
	if meters_till_next_obstacle < 0:
		SpawnObstacleScreen()	

func SpawnObstacleScreen():
	meters_till_next_obstacle = randf_range(current_min_meters, current_max_meters)
	var new_screen_type = randi() % ObstacleType.OBSTACLE_TYPE_MAX
	match new_screen_type:
		ObstacleType.ONE_SLOT_STATIC:
			#Get a random obstacle
			var new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
			var random_pos : Vector3 = Vector3(random_pos_index_to_vector(randi()%3).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(random_pos,random_pos)
		ObstacleType.TWO_SLOT_STATIC:
			var rand_for_two_slot_or_two_individual = randi()%2
			if rand_for_two_slot_or_two_individual == 0:
				#Get a random position
				var random_index_1 = 1
				var random_index_2 = randi()%3
				while random_index_1 == random_index_2:
					random_index_2 = randi()%3
				#Get an obstacle to spawn
				var new_obstacle = instantiate_an_obstacle(Two_Slot_Static_Prefabs)
				var random_pos_1 : Vector3 = Vector3(random_pos_index_to_vector(random_index_1).x, new_obstacle.position.y,new_obstacle.position.z)
				var random_pos_2 : Vector3 = Vector3(random_pos_index_to_vector(random_index_2).x, new_obstacle.position.y,new_obstacle.position.z)
				var result_pos = (random_pos_1+random_pos_2)/2
				new_obstacle.program_movement(result_pos, result_pos)
			else:
				#Get a random position
				var random_index_1 = randi()%3
				var random_index_2 = randi()%3
				while random_index_1 == random_index_2:
					random_index_2 = randi()%3
				#Get an obstacle to spawn
				var new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
				var random_pos_1 : Vector3 = Vector3(random_pos_index_to_vector(random_index_1).x, new_obstacle.position.y,new_obstacle.position.z)
				new_obstacle.program_movement(random_pos_1, random_pos_1)
				#Get another individual obstacle to spawn
				new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
				var random_pos_2 : Vector3 = Vector3(random_pos_index_to_vector(random_index_2).x, new_obstacle.position.y,new_obstacle.position.z)
				new_obstacle.program_movement(random_pos_2, random_pos_2)
		ObstacleType.ONE_SLOT_MOVING:
			#Get a random position
			var random_index_1 = 1
			var random_index_2 = randi()%3
			while random_index_1 == random_index_2:
				random_index_2 = randi()%3
			#Get an obstacle to spawn
			var new_obstacle = instantiate_an_obstacle(One_Slot_Moving_Prefabs)
			var random_pos_1 : Vector3 = Vector3(random_pos_index_to_vector(random_index_1).x, new_obstacle.position.y,new_obstacle.position.z)
			var random_pos_2 : Vector3 = Vector3(random_pos_index_to_vector(random_index_2).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(random_pos_1, random_pos_2)
		ObstacleType.ONE_STATIC_ONE_MOVE:
			#Get a random position
			var random_index_1 = 1
			var random_index_2 = randi()%3
			while random_index_1 == random_index_2:
				random_index_2 = randi()%3
			#Get an obstacle to spawn
			var new_obstacle = instantiate_an_obstacle(One_Slot_Moving_Prefabs)
			var random_pos_1 : Vector3 = Vector3(random_pos_index_to_vector(random_index_1).x, new_obstacle.position.y,new_obstacle.position.z)
			var random_pos_2 : Vector3 = Vector3(random_pos_index_to_vector(random_index_2).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(random_pos_1, random_pos_2)
			#Get the last position remaining
			var index_static_slot = 3 - (random_index_1 + random_index_2)
			new_obstacle = instantiate_an_obstacle(One_Slot_Static_Prefabs)
			var static_pos : Vector3 = Vector3(random_pos_index_to_vector(index_static_slot).x, new_obstacle.position.y,new_obstacle.position.z)
			new_obstacle.program_movement(static_pos,static_pos)
		#ObstacleType.TWO_SLOT_MOVE:
			#var x_pos_1 = (LeftPositionNode.position.x + CentralPositionNode.position.x) / 2 
			#var x_pos_2 = (RightPositionNode.position.x + CentralPositionNode.position.x) / 2 
			##Get an obstacle to spawn
			#var new_obstacle = instantiate_an_obstacle(Two_Slot_Moving_Prefabs)
			#var random_pos_1 : Vector3 = Vector3(x_pos_1, new_obstacle.position.y,new_obstacle.position.z)
			#var random_pos_2 : Vector3 = Vector3(x_pos_2, new_obstacle.position.y,new_obstacle.position.z)
			#new_obstacle.program_movement(random_pos_1, random_pos_2)
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
	
func on_get_ready_to_run(drunk_val):
	meters_till_next_obstacle = meters_per_obstacle
	current_min_meters = min_meters
	current_max_meters = max_meters
	decrease_meters_timer.start()
	game_lost = false
	
func on_game_lost():
	current_min_meters = min_meters
	current_max_meters = max_meters
	decrease_meters_timer.stop()
	game_lost = true

func decrease_meters_timer_ended():
	var step = 18
	current_min_meters = clamp(current_min_meters - step, final_min_meters, min_meters)
	current_max_meters = clamp(current_max_meters - step, final_max_meters, max_meters)
