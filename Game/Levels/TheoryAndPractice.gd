extends Node

func _ready():
	if Main.current_chapter == null:
		Main.current_chapter = 1
	
	# Crea la data del chapter si no existe
	ChaptersData.create_data(Main.current_chapter)
	
	var cap = str("Cap", Main.current_chapter)
	
	if Main.data["Chapters"][cap]["TheoryCompleted"] == true:
		$VBox/Practice.disabled = false

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Theory_pressed():
	Main.current_stage = Main.THEORY

	MusicManager.select_music(MusicManager.THEORY)
	MusicManager.play_music()
	
	get_tree().change_scene(str("res://Game/Levels/Pseudocode/Cap", Main.current_chapter, "Theory.tscn"))

func _on_Practice_pressed():
	Main.current_stage = Main.PRACTICE

	MusicManager.select_music(MusicManager.THEORY)
	MusicManager.play_music()

	get_tree().change_scene(str("res://Game/Levels/Pseudocode/Cap", Main.current_chapter, "Practice.tscn"))
