extends Node

func _ready():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(false)

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
	
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")
