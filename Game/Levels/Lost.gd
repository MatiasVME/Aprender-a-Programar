extends Node

func _ready():
	MusicManager.select_music(MusicManager.LOST)
	MusicManager.play_music()

func _on_Back_pressed():
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")
