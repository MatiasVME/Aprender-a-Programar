extends Node

func _ready():
	pass

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_Fast_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.bb_mode = Main.BBFAST
	get_tree().change_scene("res://Game/MiniGames/BubbleBoolean/BubbleBoolean.tscn")

func _on_Normal_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.bb_mode = Main.BBNORMAL
	get_tree().change_scene("res://Game/MiniGames/BubbleBoolean/BubbleBoolean.tscn")

func _on_Slow_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.bb_mode = Main.BBSLOW
	get_tree().change_scene("res://Game/MiniGames/BubbleBoolean/BubbleBoolean.tscn")

