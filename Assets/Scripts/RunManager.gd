class_name RunManager
extends Node

var player_points : int = 0
var player_velocity : float = 0
var player_acceleration : float = 0
var player_is_stunned = false
var player_is_playing = false

var player_hit_timer : Timer = null
var player_visualizer = null
var ui_manager = null
var environment_spawner = null
var obstacles_spawner = null

func _ready():
	Globals.get_ready_to_run.connect(on_get_ready_to_run)
	Globals.player_hit.connect(on_player_hit)
	Globals.obstacle_avoided.connect(on_obstacle_evaded)

func _process(delta):
	#Game not started or game over
	if not player_is_playing:
		return
		
	#Update every visual element
	player_visualizer.AdaptToVelocity(player_velocity)
	ui_manager.AdaptToVelocity(player_velocity)
	#Calculate new spawnables
	environment_spawner.PlayerIsRunning(player_velocity)
	environment_spawner.PlayerIsRunning(player_velocity)
	#Accelerate, add runned points...
	Run(delta)

func Run(deltaTime):
	#If player is "stunned" dont accelerate until recovered
	if !player_is_stunned:
		player_velocity = player_velocity + (player_acceleration*deltaTime)#Accelerate
		
	var additional_points = 0
	player_points = player_points + additional_points

#SIGNALS
func on_get_ready_to_run():
	player_points = 0
	player_velocity = 0
	player_acceleration = 0
	player_is_playing = false
	player_is_stunned = false

func on_obstacle_evaded(points_won):
	player_points = player_points + points_won
	ui_manager.VisualFeedback()
	player_visualizer.VisualFeedBack()

func on_player_hit(vel_reduction):
	player_is_stunned = true
	player_hit_timer.start()
	player_velocity = player_velocity - vel_reduction 
	if player_velocity < Globals.MIN_RUNNING_VEL:
		Globals.player_lost.emit()
		
func on_hit_timer_ended():
	player_is_stunned = false
	player_hit_timer.stop() #just in case
