extends Node3D

var velocity:float
var m:float
var children : Array[ShaderMaterial]
var localTime : float = 0.0
var offset : float = 0.0
var menos:float  = 1.0

func _ready():
	for c in get_children():
		var meshMat = c as MeshInstance3D
		children.push_back(meshMat.get_surface_override_material(0))


func _process(delta):
	#Seteamos nosotros el calculo del offset entero
	localTime += delta
	
	offset = (localTime/60.0 * velocity) 
	offset =  offset - floor(offset) - menos #Offset entre 0 y 1
	
	set_offset_to_shaders(offset)
	
	if OS.is_debug_build():
		test_vel()
		
func test_vel():
	if Input.is_key_pressed(KEY_1):
		set_velocity(10)
			
	if Input.is_key_pressed(KEY_2):
		set_velocity(50)
			
	if Input.is_key_pressed(KEY_3):
		set_velocity(100)

func set_offset_to_shaders(offset:float):
	for c in children:
		c.set_shader_parameter("offset", offset)

#Seteamos la velocidad que va a tener todo el escenario
func set_velocity(vel:float):
	velocity = vel
	
	#Calculo del siguiente offset para ajustar y que no haga salto
	var fakeoffset = localTime/60.0 * velocity
	fakeoffset =  fakeoffset - floor(fakeoffset) #Offset entre 0 y 1
	menos = fakeoffset - offset
	if(menos < 0):
		menos = 1 + menos
		print("Paso lo que paso")
