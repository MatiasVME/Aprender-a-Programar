extends Node

var texts = [
		"Syntax Error -- Compiler",
		"No temo a los ordenadores; lo que temo es quedarme sin ellos -- Isaac Asimov",
		"La simplicidad llevada al extremo se convierte en elegancia -- Jon Franklin",
		"Is not a bug is a feature"
	]

func _ready():
	randomize()
	var rand_text_num = int(round(rand_range(0, texts.size() - 1)))
	$Text.text = texts[rand_text_num]

func _on_Anim_animation_finished(anim_name):
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")
