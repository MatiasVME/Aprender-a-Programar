extends Node

func _ready():
	pass

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(meta)

func _on_Yes_pressed():
	Main.data["AcceptPrivacyPolicy"] = true
	
	Main.all_data_config()
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_Exit_pressed():
	get_tree().quit()
