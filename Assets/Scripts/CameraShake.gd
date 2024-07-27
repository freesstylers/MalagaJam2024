extends Camera3D

const MAX_SHAKE = 2.5
const MIN_SHAKE = 0.75

@export var randomStrength : float = 2.0
@export var shakeFade : float = 5.0

var shake_strength : float = 0.0

func _ready():
	Globals.obstacle_hit.connect(apply_shake)
	shake_strength = MIN_SHAKE

func apply_shake(vel_reduction):
	var factor = vel_reduction/(Globals.MAX_RUNNING_VEL-Globals.MIN_RUNNING_VEL)
	shake_strength = MIN_SHAKE + ((MAX_SHAKE-MIN_SHAKE) * factor)

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade*delta)
	var offset = randomOffset()
	h_offset = offset.x
	v_offset = offset.y
	
func randomOffset():
	return Vector2(randf_range(-shake_strength, shake_strength),randf_range(-shake_strength, shake_strength))
