extends Node

func _ready():
	pass

func _on_Google_pressed():
	if Main.firebase != null:
		if not Main.firebase.is_google_connected():
			Main.firebase.google_sign_in()
			
			if Main.firebase.is_google_connected():
				var new_texture = load("res://Game/Buttons/Social/Google-ok.png")
				$Google.texture_normal = new_texture
		else:
			Main.firebase.google_sign_out()
			
			if not Main.firebase.is_google_connected():
				var new_texture = load("res://Game/Buttons/Social/Google-not-actived.png")
				$Google.texture_normal = new_texture


func _on_Facebook_pressed():
	if Main.firebase != null:
		if not Main.firebase.is_facebook_connected():
			Main.firebase.facebook_sign_in()
			
			if Main.firebase.is_facebook_connected():
				var new_texture = load("res://Game/Buttons/Social/Facebook-ok.png")
				$Facebook.texture_normal = new_texture
		else:
			Main.firebase.facebook_sign_out()
			
			if not Main.firebase.is_facebook_connected():
				var new_texture = load("res://Game/Buttons/Social/Facebook-not-actived.png")
				$Facebook.texture_normal = new_texture

func _on_SMS_pressed():
	if Main.firebase != null:
		# TODO: Cambiar enlace
		firebase.invite("Hola, descubrí esta aplicación muy buena para aprender a programar de forma muy fácil y entretenida. Saludos", "https://example.com/beed/link")
