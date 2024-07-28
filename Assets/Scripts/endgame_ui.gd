extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_text()
	Globals.player_lost.connect(update_text)

func _on_repeat_pressed():
	Globals.SceneMngr.playButtonSFX()
	Globals.SceneMngr.load_scene(Globals.Scene.MENU_SCENE)

func _on_share_pressed():
	Globals.SceneMngr.playButtonSFX()
	var url = "https://twitter.com/intent/tweet?text=" + ("¡Mi nivel de cuñado ha sido: %s" % Globals.finalScore + "!\n\nSoy un " + prizeTitle + "\n\nJuega a \"Jefe, La Cuenta\" de @FreeStylers_Dev para la #MJW18 en https://freestylers-studio.itch.io/jefe-la-cuenta").uri_encode()
	OS.shell_open(url)

var prizeTitle : String = ""
	
func update_text():
	$Panel/Panel/VBoxContainer/Puntuacion.text = "[center][font_size={48}]Puntuación[/font_size]
	[font_size={36}]%s" % Globals.finalScore + "[/font_size]
	-----[/center]"
	
	if Globals.finalScore < 100:
		prizeTitle = "Borrachín Novato"
	elif Globals.finalScore < 200:
		prizeTitle = "Verbenero Estándar"
	elif Globals.finalScore < 300:
		prizeTitle = "Bebedor Habitual"
	elif Globals.finalScore < 400:
		prizeTitle = "Cierrabares"
	elif Globals.finalScore < 500:
		prizeTitle = "Maestro Cervecero"
	else:
		prizeTitle = "Baco Dios del Alcohol"
	
	$Panel/Panel/VBoxContainer/Premio.text = "[center][font_size={48}]Título[/font_size]
[font_size={24}]" + prizeTitle + "[/font_size][/center]"
