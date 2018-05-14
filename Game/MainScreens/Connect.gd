extends Node

func _ready():
	firebase_things()

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_GoogleGames_pressed():
	Main.init_google_games()
