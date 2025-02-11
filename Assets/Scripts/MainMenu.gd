extends Control

@export var meCagoEnTusMuertos: Font

# Called when the node enters the scene tree for the first time.
func _ready():
	meCagoEnTusMuertos.fixed_size = 0

func FreeStylers():
	Globals.SceneMngr.playButtonSFX()
	OS.shell_open("https://freestylers-studio.itch.io/")

func Jam():
	Globals.SceneMngr.playButtonSFX()
	OS.shell_open("https://itch.io/jam/malagajam-weekend-18")

func Twitter():
	Globals.SceneMngr.playButtonSFX()
	OS.shell_open("https://twitter.com/FreeStylers_Dev")

func _on_quit_pressed():
	Globals.SceneMngr.playButtonSFX()
	get_tree().quit()

func _on_credits_pressed():
	Globals.SceneMngr.playButtonSFX()
	$CanvasLayer/Credits.visible = true

func _on_how_to_play_pressed():
	Globals.SceneMngr.playButtonSFX()
	$CanvasLayer/HowToPlay.visible = true

func _on_play_pressed():
	Globals.SceneMngr.playButtonSFX()
	Globals.SceneMngr.load_scene(Globals.Scene.DRINK_SCENE)

func _on_credits_close_pressed():
	Globals.SceneMngr.playButtonSFX()
	$CanvasLayer/Credits.visible = false

func _on_how_to_play_close_pressed():
	Globals.SceneMngr.playButtonSFX()
	$CanvasLayer/HowToPlay.visible = false
