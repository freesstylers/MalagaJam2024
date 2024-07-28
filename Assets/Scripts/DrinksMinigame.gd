extends Control

@export var drinksSprites : Array[Texture]
@export var UI: Control
@export var extraFocus : Button
var rng = RandomNumberGenerator.new()

@export var DrinksSFX : AudioStreamPlayer2D = null

var score = 0.0

@export var secondsMinigame : float = 7.0

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0.0
	var index:int = 0
	for iteration in get_children():
		iteration.icon = drinksSprites[rng.randf_range(0, drinksSprites.size()-1)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	secondsMinigame -= delta
	
	if secondsMinigame <= 0:
		Globals.SceneMngr.load_scene(Globals.Scene.PLAY_SCENE)
		Globals.get_ready_to_run.emit(score/100.0)
		pass

func _on_drink_pressed(index):
	if get_child(index).icon == drinksSprites[0]:
		score += 3
	elif get_child(index).icon == drinksSprites[1]:
		score += 6
	elif get_child(index).icon == drinksSprites[2]:
		score += 9 		
	elif get_child(index).icon == drinksSprites[3]:
		score += 12 
	elif get_child(index).icon == drinksSprites[4]:
		score += 15 
	elif get_child(index).icon == null:
		pass

	UI.current_bar_value = score
	
	DrinksSFX.play()
	get_child((index)).icon = null #Deactivate
	get_child((index)).scale = Vector2(0.01, 0.01)
	extraFocus.grab_focus()
	
	var localTween = create_tween()
	
	localTween.tween_callback(func(): 
		get_child(index).icon = drinksSprites[rng.randf_range(0, drinksSprites.size()-1)]
		
		var localTween2 = create_tween()
		localTween2.tween_property(get_child(index), "scale", Vector2(6,6), 0.25)
		
		#Set scale increasingly
		).set_delay(rng.randf_range(0.5, 1.5))
		#Reactivate
