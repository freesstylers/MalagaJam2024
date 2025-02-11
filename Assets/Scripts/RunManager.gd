class_name RunManager
extends Node

@onready var hitSounds : AudioStreamPlayer = $CrashSounds
@onready var dodgeSound : AudioStreamPlayer = $DodgeSound
@onready var gameOverSound : AudioStreamPlayer = $GameOverSound

@export var music : AudioStreamPlayer = null

@export var road_manager : RoadManager = null
@export var obstacle_spawn_manager : ObstaclesSpawnManager = null
@export var scenary_visuals : ScenaryVisualizer = null
@export var ui_manager : InGameUIManager = null
@export var main_char : MainChar = null
var player_visualizer = null

var player_points : float = 0.0
var player_velocity : float = Globals.MIN_RUNNING_VEL
var player_acceleration : float = Globals.MIN_RUNNING_ACCELERATION
var player_is_stunned = false
var player_is_playing = true

var drunk_percentage : float = 1.0

var game_lost : bool = false

@onready var player_hit_timer : Timer = $HitTimer

func _ready():
	Globals.get_ready_to_run.connect(on_get_ready_to_run)
	Globals.obstacle_hit.connect(on_obstacle_hit)
	Globals.obstacle_avoided.connect(on_obstacle_avoided)
	Globals.player_lost.connect(on_game_lost)

func _process(delta):		
	#Update every visual element
	#player_visualizer.AdaptToVelocity(player_velocity)
	ui_manager.update_player_velocity(player_velocity)
	#Control 
	var movement = player_velocity * delta
	road_manager.PlayerIsRunning(movement)
	obstacle_spawn_manager.PlayerIsRunning(movement)
	scenary_visuals.set_velocity((player_velocity / Globals.MAX_RUNNING_VEL)*100)
	#Accelerate, add runned points...
	Run(delta)
	main_char.set_animation_speed(player_velocity)
	if game_lost:
		return
	player_points += (movement + movement * drunk_percentage) * delta
	Globals.finalScore = player_points as int
	ui_manager.update_score(round(player_points))

func Run(deltaTime):
	#If player is "stunned" dont accelerate until recovered
	if !player_is_stunned:
		player_velocity = clampf(player_velocity + (player_acceleration*deltaTime), Globals.MIN_RUNNING_VEL, Globals.MAX_RUNNING_VEL)#Accelerate

#SIGNALS
func on_get_ready_to_run(drunk_meter):
	player_points = 0
	Globals.finalScore = player_points
	player_velocity = 0
	player_is_playing = false
	player_is_stunned = false
	
	drunk_percentage = drunk_meter
	
	game_lost = false
	
	road_manager.clear_obstacles()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func on_obstacle_avoided():
	dodgeSound.play()

func on_obstacle_hit(vel_reduction):
	player_is_stunned = true
	# Perder
	if player_velocity < Globals.DEATH_VEL:
		Globals.player_lost.emit()
		player_velocity = 5.0
		music.stop()
		gameOverSound.play()
		return
	player_hit_timer.start()
	var local_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	local_tween.tween_property(self, "player_velocity",player_velocity - vel_reduction,  0.1)
	
	hitSounds.play()
		
func on_hit_timer_ended():
	player_is_stunned = false
	player_hit_timer.stop() #just in case
	
func on_game_lost():
	game_lost = true
