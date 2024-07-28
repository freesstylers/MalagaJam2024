extends TextureRect

func _ready():
	Globals.get_ready_to_run.connect(on_get_ready)
	
func on_get_ready(drunk_meter):
	visible = true
