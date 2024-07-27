class_name InGameUIManager
extends Node

@export var lerp_factor : float = 1
@onready var speed_bar : ProgressBar = $CanvasLayer/TextureRect/ProgressBar

var visual_bar_value : float = 0
var current_bar_value : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visual_bar_value = visual_bar_value + ((current_bar_value-visual_bar_value) * lerp_factor * delta)
	speed_bar.value = visual_bar_value

func update_player_velocity(player_velocity):
	var bar_value = (player_velocity - Globals.MIN_RUNNING_VEL)/(Globals.MAX_RUNNING_VEL - Globals.MIN_RUNNING_VEL) 
	current_bar_value = bar_value * 100
