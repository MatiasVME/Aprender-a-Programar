extends Node

func _ready():
	pass

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_Music_toggled(button_pressed):
	if button_pressed:
		Main.music_enable = false
		MusicManager.stop_music()
	else:
		Main.music_enable = true
		MusicManager.play_music()

func _on_ConfirmationDialog_confirmed():
	Persistence.remove_all_data()
	get_tree().quit()

func _on_DeleteData_pressed():
	$ConfirmationDeleteData.show()
