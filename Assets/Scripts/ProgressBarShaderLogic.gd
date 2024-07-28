class_name ProgressBeer
extends ProgressBar

@export var mat:ShaderMaterial
var progress

func _ready():
	mat = material as ShaderMaterial
	mat.set_shader_parameter("p", 0.0)
	
func set_progress(p:float):
	mat.set_shader_parameter("p", p/100.0)
	pass
