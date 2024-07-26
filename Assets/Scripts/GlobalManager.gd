class_name SceneManager
extends Node2D

@export var MaxLevels : int
@export var Game_Scenes : Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.SceneMngr = self

var currentLevel = -1

func startGame(level: int):
	$TransitionScreen.transition()
	currentLevel = level
	
func _on_transition_screen_screen_transitioned(currentLevel):
	match currentLevel:
		Globals.Scene.MAIN_SCENE:
			pass

func get_current_scene_node():
	pass

func load_scene(name):
	var current = get_current_scene_node()
	current.queue_free()
	
func fade_in_():
	pass

func fade_out():
	pass

func playButtonSFX():
	pass
