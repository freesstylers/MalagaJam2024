extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(2,2), 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.5)
	tween.set_loops()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
