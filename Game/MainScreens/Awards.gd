extends Node

func _ready():
	pass

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_Data_pressed():
	get_tree().change_scene("res://Game/MainScreens/Data.tscn")
