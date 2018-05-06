extends Node

func _ready():
	randomize()
	
	firebase_things()
	
	$Version.text = Main.version
	
	# El bbcode_text tiene que estar vacio
	if Main.firebase != null:
		var rand_num = int(round(rand_range(1, 5)))
		$Notes/Text.bbcode_text = Main.firebase.getRemoteValue(str("welcome_message_", rand_num))
		
		# A veces puede que siga estando vacio el texto después de pedirlo
		if $Notes/Text.bbcode_text == "" or $Notes/Text.bbcode_text == "NULL":
			$Notes.hide()
	else:
		$Notes.hide()

func _on_Connect_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()

	get_tree().change_scene("res://Game/MainScreens/Connect.tscn")

func _on_Exit_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().quit()

func _on_Awards_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Awards.tscn")
	
func _on_Modes_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_Options_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Options.tscn")

func firebase_things():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)

		var google_user = Main.firebase_get_google_user()
		if google_user != null:
			$User.text = google_user["name"]
		else:
			$User.text = "..."
	else:
		$Grid/Connect.disabled = true

func _on_Credits_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Credits.tscn")

func _on_Text_meta_clicked(meta):
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	OS.shell_open(meta)
