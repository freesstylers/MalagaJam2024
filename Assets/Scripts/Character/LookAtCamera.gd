extends Node3D

func _ready():
	var camerapos = get_viewport().get_camera_3d().position
	var cameraxrot = -get_viewport().get_camera_3d().rotation.x
	rotation.x = cameraxrot
	
