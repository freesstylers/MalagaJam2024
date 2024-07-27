extends Sprite3D

func _ready():
	var camerapos = get_viewport().get_camera_3d().position
	var cameraxrot = get_viewport().get_camera_3d().rotation.x
	rotate_x(cameraxrot)
	#look_at(camerapos)
	
