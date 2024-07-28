extends Control

@export var drinksSprites : Array[Texture]
@export var UI: ProgressBeer
@export var extraFocus : Button
var rng = RandomNumberGenerator.new()

@export var DrinksSFX : AudioStreamPlayer2D = null

var score = 0.0

@export var secondsMinigame : float = 7.0
@export var maxScore : float = 100.0

@export var videoPlayer : VideoStreamPlayer = null
@export var Frases : AudioStreamPlayer2D = null
# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0.0
	var index:int = 0
	for iteration in get_children():
		iteration.icon = drinksSprites[rng.randf_range(0, drinksSprites.size())]

var change : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	secondsMinigame -= delta
	
	if secondsMinigame <= 0:
		if not change:
			change = true
			videoPlayer.visible = true	
			videoPlayer.play()
			DrinksSFX.stop()
			var frasestween : Tween = Frases.create_tween()
			frasestween.tween_callback(func():
				Frases.play()
				).set_delay(3.0)
			

func _on_drink_pressed(index):
	if get_child(index).icon == drinksSprites[0]:
		score += 3.0
	elif get_child(index).icon == drinksSprites[1]:
		score += 6.0
	elif get_child(index).icon == drinksSprites[2]:
		score += 9.0
	elif get_child(index).icon == drinksSprites[3]:
		score += 12.0
	elif get_child(index).icon == drinksSprites[4]:
		score += 15.0
	elif get_child(index).icon == null:
		pass
	
	if score >= maxScore:
		score = maxScore
	
	UI.set_progress(score)
	
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


func _on_video_stream_player_finished():
	videoPlayer.stop()
	Globals.SceneMngr.load_scene(Globals.Scene.PLAY_SCENE)
	Globals.get_ready_to_run.emit(score/100.0)
