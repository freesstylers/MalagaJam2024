class_name ProgressBeer
extends ProgressBar

@export var mat:ShaderMaterial
var progress

func _ready():
	mat = material as ShaderMaterial
	
func set_progress(p:float):
	mat.set_shader_parameter("p", p/100.0)
	pass
