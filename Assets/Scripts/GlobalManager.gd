class_name SceneManager
extends Node2D

@export var MaxLevels : int
@export var Game_Scenes : Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.SceneMngr = self
	load_scene(0)
	
var currentLevel = -1

func startGame(level: int):
	$TransitionScreen.transition()
	currentLevel = level
	
func _on_transition_screen_screen_transitioned(currentLevel):
	match currentLevel:
		Globals.Scene.MAIN_SCENE:
			pass

func get_current_scene_node():
	return get_child(0)
	pass

func load_scene(number : int):
	var current = get_current_scene_node().get_child(0) #CurrentScene
	
	if current != null:
		current.queue_free()
	
	match (number):
		Globals.Scene.SPLASH_SCREEN:
			get_child(0).add_child(Game_Scenes[number].instantiate())
			$FreeStylersSplash.play()
	
func fade_in_():
	pass

func fade_out():
	pass

func playButtonSFX():
	pass
