extends Node

func _ready():
	firebase_things()

func _on_Google_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	if Main.firebase != null:
		if not Main.firebase.is_google_connected():
			Main.firebase.google_sign_in()
	
func _on_SMS_pressed(): # TODO
	if Main.firebase != null:
		# TODO: Cambiar enlace
		Main.firebase.invite("Hola, descubrí esta aplicación muy buena para aprender a programar de forma muy fácil y entretenida.", "https://example.com/beed/link")

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_Timer_timeout():
	firebase_things()
		
func hide_all_buttons():
	$Google.hide()
	$Facebook.hide()
	$SMS.hide()
	
	$Title.text = "No hay conexión a internet"

func show_all_buttons_if_can():
	if Main.firebase.is_google_connected():
		$Google.show()
		$GoogleLogout.show()
		
		var google_user = Main.firebase_get_google_user()
		if google_user != null:
			$Welcome.text = str("Bienvenid@ ", google_user["name"])
	else:
		$GoogleLogout.hide()
		$Welcome.text = "..."
#	if Main.firebase.is_facebook_connected():
#		$Facebook.show()

#	$SMS.show()
	
	$Title.text = "Conectate con Google"

func firebase_things():
	if Main.firebase != null:
		show_all_buttons_if_can()
	else:
		hide_all_buttons()

func _on_GoogleLogout_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	Main.current_user = null
	Main.firebase.google_sign_out()
