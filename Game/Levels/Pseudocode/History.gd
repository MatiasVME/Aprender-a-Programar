extends Node

func _ready():
	pass

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_Cap1_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/Cap1Theory.tscn")

func _on_Cap2_pressed():
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap3_pressed():
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")
