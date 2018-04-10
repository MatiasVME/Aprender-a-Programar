extends Node

var firebase
var ot = true

func _ready():
	firebase = Engine.get_singleton("FireBase");
	print(str(firebase))
	
	if OS.get_name() == "Android":
		var file = File.new()
		file.open("res://godot-firebase-config.json", file.READ)
		var content = file.get_as_text()
		file.close()

		firebase.init(content, get_instance_id())

	if firebase != null:
#		firebase.google_sign_in() # Funciona :D
#		firebase.show_banner_ad(true) # Funciona :D
#		firebase.show_rewarded_video()
#		firebase.invite("message", "hola")
		pass

	if firebase != null:
		$Text1.text = str(firebase)
		$Text2.text = str(firebase.is_banner_loaded())
	
func _receive_message(tag, from, key, data):
	if tag == "FireBase":
		print("From: ", from, " Key: ", key, " Data: ", data)

func _on_Button_pressed():
	if firebase.request_rewarded_video_status():
		firebase.show_rewarded_video()

func _on_Anim_animation_finished(anim_name):
	ot = true

func _on_Timer_timeout():
	print("TIMER")
	if firebase.request_rewarded_video_status() != null and ot:
		ot = false
		$Anim.play("anim")
