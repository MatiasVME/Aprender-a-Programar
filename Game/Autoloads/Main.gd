extends Node

const RES_X = 1280
const RES_Y = 720

var version = "v0.1.0"
var music_enable = true
var debug = true

var pseudocode_max_level = 1

var firebase
var google_user

func _ready():
	firebase_config()
	firebase_auth_config()
	google_user = firebase_get_google_user()
	
func firebase_config():
	firebase = Engine.get_singleton("FireBase");
	
	if OS.get_name() == "Android":
		var file = File.new()
		file.open("res://godot-firebase-config.json", file.READ)
		var content = file.get_as_text()
		file.close()
		
		firebase.init(content, get_instance_id())

func firebase_auth_config():
	if firebase != null:
		firebase.authConfig("'Google':true,'Facebook':true")
	
func _receive_message(tag, from, key, data):
	if tag == "FireBase":
		print("From: ", from, " Key: ", key, " Data: ", data)

func firebase_get_google_user():
	if firebase != null:
		var guser = Main.firebase.get_google_user()
	
		if guser != null:
			return parse_json(guser)

#func firebase_send_custom(event_key, event_value):
#	if Main.firebase != null:
#		Main.firebase.send_custom(event_key, event_value)