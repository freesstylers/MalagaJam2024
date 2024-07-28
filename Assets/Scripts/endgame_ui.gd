extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_text()
	Globals.player_lost.connect(update_text)

	#$Panel/Panel/VBoxContainer/Premio.text = "[center][font_size={48}]Título[/font_size]
#[font_size={24}]XXXX[/font_size][/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_repeat_pressed():
	Globals.SceneMngr.load_scene(Globals.Scene.MENU_SCENE)

func _on_share_pressed():
	var url = "https://twitter.com/intent/tweet?text=" + ("¡Mi nivel de cuñado ha sido: %s" % Globals.finalScore + "!\n\nJuega a \"Jefe, la cuenta\" en https://freestylers-studio.itch.io/jefe-la-cuenta").uri_encode()
	OS.shell_open(url)

func update_text():
	$Panel/Panel/VBoxContainer/Puntuacion.text = "[center][font_size={48}]Puntuación[/font_size]
	[font_size={36}]%s" % Globals.finalScore + "[/font_size]
	-----[/center]"
