extends Node

func _ready():
	pass

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_History_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_BubbleBool_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/OptionsBubbleBool.tscn")