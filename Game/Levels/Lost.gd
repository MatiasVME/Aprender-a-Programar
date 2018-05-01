extends Node

func _ready():
	MusicManager.select_music(MusicManager.LOST)
	MusicManager.play_music()

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Reload_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	MusicManager.select_music(MusicManager.THEORY)
	MusicManager.play_music()
	
	get_tree().change_scene(str("res://Game/Levels/Pseudocode/Cap", Main.current_chapter, "Practice.tscn"))