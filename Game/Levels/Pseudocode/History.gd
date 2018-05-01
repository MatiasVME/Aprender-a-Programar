extends Node

func _ready():
	enable_buttons()

func enable_buttons():
	# Testear esto
	for i in range(1, Main.data["PseudocodePastsLevels"] + 1):
		if has_node(str("Panel/Margin/Scroll/Grid/Cap", i)):
			get_node(str("Panel/Margin/Scroll/Grid/Cap", i)).disabled = false

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_Cap1_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.current_chapter = 1
	Main.current_stage = Main.THEORY
	
	MusicManager.select_music(MusicManager.THEORY)
	MusicManager.play_music()
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/Cap1Theory.tscn")

func _on_Cap2_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.current_chapter = 2
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap3_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.current_chapter = 3
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap4_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.current_chapter = 4
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap5_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.current_chapter = 5
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap6_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.current_chapter = 6
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")
