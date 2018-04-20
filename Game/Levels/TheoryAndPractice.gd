extends Node

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Theory_pressed():
	Main.current_stage = Main.THEORY
	
	get_tree().change_scene(str("res://Game/Levels/Pseudocode/Cap", Main.current_chapter, "Theory.tscn"))

func _on_Practice_pressed():
	Main.current_stage = Main.PRACTICE
	get_tree().change_scene(str("res://Game/Levels/Pseudocode/Cap", Main.current_chapter, "Practice.tscn"))
