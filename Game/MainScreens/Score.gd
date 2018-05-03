extends Node

func _ready():
#	if Main.firebase != null:
#		var data = {}
#		data["algo"] = "algo"
#		Main.firebase.add_document("users", data)
##		Main.firebase.set_document("users", "score", data)
	pass

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Awards.tscn")
