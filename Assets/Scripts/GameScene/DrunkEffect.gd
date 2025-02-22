extends ColorRect

func _ready():
	Globals.get_ready_to_run.connect(on_ready_to_run)
	Globals.end_game.connect(on_end_game)
	
func on_ready_to_run(drunk_meter):
	var shader = material as ShaderMaterial
	shader.set_shader_parameter("distorsion_factor", 10*drunk_meter)
	
func on_end_game():
	#Devolvemos el valor a 0
	var shader = material as ShaderMaterial
	shader.set_shader_parameter("distorsion_factor", 0.0)
