extends Node

func _ready():
	if Main.data["GoogleGames"]:
		$All/GoogleGamesCheck.pressed = true

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_Music_toggled(button_pressed):
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	if button_pressed:
		Main.music_enable = false
		MusicManager.stop_music()
	else:
		Main.music_enable = true
		MusicManager.play_music()

func _on_ConfirmationDialog_confirmed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Persistence.remove_all_data()
	get_tree().quit()

func _on_DeleteData_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	$ConfirmationDeleteData.show()

func _on_GoogleGamesCheck_toggled(button_pressed):
	if button_pressed:
		Main.init_google_games()
		Main.data["GoogleGames"] = true
		Persistence.save_data(Main.current_user)
	else:
		if Main.google_games != null:
			Main.google_games.logout()
		
		Main.data["GoogleGames"] = false
		Persistence.save_data(Main.current_user)