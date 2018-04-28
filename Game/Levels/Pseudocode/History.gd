extends Node

func _ready():
	enable_buttons()

func enable_buttons():
	for i in range(1, Main.data["PseudocodePastsLevels"] + 1):
		get_node(str("Panel/Margin/Scroll/Grid/Cap", i)).disabled = false

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_Cap1_pressed():
	Main.current_chapter = 1
	Main.current_stage = Main.THEORY
	
	MusicManager.select_music(MusicManager.THEORY)
	MusicManager.play_music()
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/Cap1Theory.tscn")

func _on_Cap2_pressed():
	Main.current_chapter = 2
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap3_pressed():
	Main.current_chapter = 3
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap4_pressed():
	Main.current_chapter = 4
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")
