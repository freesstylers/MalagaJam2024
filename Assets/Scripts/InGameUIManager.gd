class_name InGameUIManager
extends Node

@export var lerp_factor : float = 3
@onready var speed_bar : ProgressBeer = $CanvasLayer/TextureRect/ProgressBar
@onready var score_meter : Label = $CanvasLayer/ScoreBackground/Score
@onready var defeat_text : Label = $CanvasLayer/TextoDerrota
@onready var end_game_UI : Control = $CanvasLayer/EndgameUI

var visual_bar_value : float = 0
var current_bar_value : float = 0

func _ready():
	defeat_text.scale = Vector2.ZERO
	Globals.player_lost.connect(on_player_lost)
	Globals.get_ready_to_run.connect(on_get_ready_to_run)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visual_bar_value = visual_bar_value + ((current_bar_value-visual_bar_value) * lerp_factor * delta)
	speed_bar.set_progress(visual_bar_value)

func update_player_velocity(player_velocity):
	var bar_value = (player_velocity - Globals.MIN_RUNNING_VEL)/(Globals.MAX_RUNNING_VEL - Globals.MIN_RUNNING_VEL) 
	current_bar_value = bar_value * 100
	
func update_score(new_score : int):
	score_meter.text = str(new_score)
	
func on_player_lost():
	var twin = create_tween()
	twin.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	twin.tween_property(defeat_text, "scale", Vector2(1,1), 1)
	twin.tween_callback(go_to_end_game).set_delay(4)
	
func go_to_end_game():
	Globals.end_game.emit()
	end_game_UI.visible = true
	score_meter.get_parent().visible = false
	speed_bar.get_parent().visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func on_get_ready_to_run(drunk_meter):
	defeat_text.scale = Vector2.ZERO
	end_game_UI.visible = false
	score_meter.get_parent().visible = true
	speed_bar.get_parent().visible = true
