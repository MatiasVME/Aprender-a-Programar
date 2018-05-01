extends Node

func _ready():
	pass

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_TextCredits_meta_clicked(meta):
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	OS.shell_open(meta)
