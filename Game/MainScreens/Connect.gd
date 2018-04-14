extends Node

var google_user

func _ready():
	firebase_things()

func _on_Google_pressed():
	if Main.firebase != null:
		if not Main.firebase.is_google_connected():
			Main.firebase.google_sign_in()

			var new_texture = load("res://Game/Buttons/Social/Google-ok.png")
			$Google.texture_normal = new_texture

func _on_SMS_pressed(): # TODO
	if Main.firebase != null:
		# TODO: Cambiar enlace
		Main.firebase.invite("Hola, descubrí esta aplicación muy buena para aprender a programar de forma muy fácil y entretenida.", "https://example.com/beed/link")

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_Timer_timeout():
	firebase_things()
		
func hide_all_buttons():
	$Google.hide()
	$Facebook.hide()
	$SMS.hide()
	
	$Title.text = "No hay conexión a internet"

func show_all_buttons_if_can(google_user):
	if Main.firebase.is_google_connected():
		$Google.show()
		$GoogleLogout.show()
		
		if google_user != null:
			var json_google_user = parse_json(google_user)
			
			$Welcome.text = str("Bienvenid@ ", json_google_user["name"])
			
			print("Google User: ", google_user)
	else:
		$GoogleLogout.hide()
		$Welcome.text = "..."
#	if Main.firebase.is_facebook_connected():
#		$Facebook.show()

#	$SMS.show()
	
	$Title.text = "Conectate con Google"

func firebase_things():
	if Main.firebase != null:
		google_user = Main.firebase.get_google_user()
		show_all_buttons_if_can(google_user)
	else:
		hide_all_buttons()

func _on_GoogleLogout_pressed():
	Main.firebase.google_sign_out()
