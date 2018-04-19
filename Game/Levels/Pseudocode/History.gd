extends Node

func _ready():
	enable_buttons()

func enable_buttons():
	for i in range(1, Main.data["PseudocodePastsLevels"] + 1):
		get_node(str("Panel/Margin/Scroll/Grid/Cap", i)).disabled = false

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_Cap1_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/Cap1Theory.tscn")

func _on_Cap2_pressed():
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")

func _on_Cap3_pressed():
	get_tree().change_scene("res://Game/Levels/TheoryAndPractice.tscn")
