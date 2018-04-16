extends Node

onready var menu = $Menu
onready var win = $Win

enum Music {MENU, WIN}
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