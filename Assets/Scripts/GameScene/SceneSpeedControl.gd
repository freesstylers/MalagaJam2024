extends Node3D

@export var velocity:float

var m:float
var children : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	children = get_children()
	m = 100.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		set_velocity(m)
		m += 10
	pass

#Seteamos la velocidad que va a tener todo el escenario
#TODO: cambiar el parametro del shader por codigo del material_override
func set_velocity(vel:float):
	for c in children:
		var mesh = c as MeshInstance3D
		mesh.set_instance_shader_parameter("multiply", vel)
