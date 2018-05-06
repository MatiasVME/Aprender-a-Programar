extends Node

var texts = [
		"Syntax Error -- Compiler",
		"No temo a los ordenadores; lo que temo es quedarme sin ellos -- Isaac Asimov",
		"La simplicidad llevada al extremo se convierte en elegancia -- Jon Franklin",
		"It's not a bug, It's a feature -- Anonymous",
		"Primero resuelve el problema. Después, escribe el código. -- John Johnson"
	]

func _ready():
	randomize()
	
	var rand_text_num = int(round(rand_range(0, texts.size() - 1)))
	$Text.text = texts[rand_text_num]
	
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()

func _on_Anim_animation_finished(anim_name):
	
	if Main.data["AcceptPrivacyPolicy"]:
		get_tree().change_scene("res://Game/MainScreens/Menu.tscn")
	else:
		get_tree().change_scene("res://Game/MainScreens/PrivacyPolicy.tscn")
	
func sound_play():
	$Tuiu.play()
