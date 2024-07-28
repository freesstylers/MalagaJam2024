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
		Globals.Scene.MENU_SCENE:
			pass

func get_current_scene_node():
	return get_child(0)
	pass

func load_scene(number : int):
	var current = get_current_scene_node()
	var currChild = null
	
	if current.get_child_count() > 0:
		currChild = current.get_child(0) #CurrentScene
		if currChild != null:
			currChild.queue_free()
			currChild = null
	
	match (number):
		Globals.Scene.SPLASH_SCREEN:
			$FreeStylersSplash.play()
		#Globals.Scene.MENU_SCENE:
		#Globals.Scene.DRINK_SCENE:
	
	if current != null:		
		get_child(0).add_child(Game_Scenes[number].instantiate())
	else:
		print("jose")
		
func fade_in_():
	pass

func fade_out():
	pass

func playButtonSFX():
	pass

func findComponentInChildren(parent, type):
	for child in parent.get_children():
		if is_instance_of(child, type):
			return child
		var grandchild = findComponentInChildren(child, type)
		if grandchild != null:
			return grandchild
	return null


func _on_free_stylers_splash_finished():
	$GodotSplash.play()
	pass # Replace with function body.


func _on_godot_splash_finished():
	$DisclaimerSplash.play()
	pass # Replace with function body.
