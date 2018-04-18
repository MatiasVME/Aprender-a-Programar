extends Node

func _ready():
	firebase_things()
	
	$Version.text = Main.version

func _on_Connect_pressed():
	# TODO: Hacer una animación para cambiar de escena
	get_tree().change_scene("res://Game/MainScreens/Connect.tscn")

func _on_Exit_pressed():
	get_tree().quit()

func _on_Awards_pressed():
	get_tree().change_scene("res://Game/MainScreens/Awards.tscn")
	
func _on_Modes_pressed():
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_Options_pressed():
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
	get_tree().change_scene("res://Game/MainScreens/Credits.tscn")
