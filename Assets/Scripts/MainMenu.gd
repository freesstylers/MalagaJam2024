extends Control

@export var FirstButton : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	#FirstButton.grab_focus()
	pass # Replace with function body.

func FreeStylers():
	Globals.SceneMngr.playButtonSFX()
	OS.shell_open("https://freestylers-studio.itch.io/")

func Jam():
	Globals.SceneMngr.playButtonSFX()
	OS.shell_open("https://itch.io/jam/malagajam-weekend-18")

func Twitter():
	Globals.SceneMngr.playButtonSFX()
	OS.shell_open("https://twitter.com/FreeStylers_Dev")
