extends Node

onready var menu = $Menu
onready var win = $Win
onready var theory = $Theory

enum Music {MENU, WIN, THEORY}
var current_music = null

func select_music(p_music):
	if not Main.music_enable:
		return
	
	if current_music != null:
		current_music.stop()
	
	match p_music:
		Music.MENU :
			current_music = menu
		Music.WIN :
			current_music = win
		Music.THEORY :
			current_music = theory
			
func play_music():
	if not Main.music_enable:
		return
	
	if current_music != null:
		current_music.play()
		
func stop_music():
	if not Main.music_enable:
		return
	
	if current_music != null:
		current_music.stop()