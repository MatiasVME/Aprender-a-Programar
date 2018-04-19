extends Node

const RES_X = 1280
const RES_Y = 720

var version = "v0.1.0"
var music_enable = true
var debug = true

var pseudocode_max_level = 1

var firebase
var google_user

# Rewards
var admob_video_is_loaded = false
var reward_amount = 1

var value_for_dialogue = 3 # TODO

# Pets
var pets_names = ["Pipo", "Stuar"]

func _ready():
	randomize()
	print(OS.get_user_data_dir())
	
	firebase_config()
	firebase_auth_config()
	google_user = firebase_get_google_user()
	
	create_data_if_not_exist()
	
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
	if tag == "FireBase" and from == "AdMob":
		if key == "AdMobReward":
			# when rewared video play complete
			print("json data with [RewardType & RewardAmount]: ", data)
			reward_amount = data["RewardAmount"]

		elif key == "AdMob_Video":
			# when rewarded video loaded
			# data will be `loaded` or `load_failed and `loaded` or `not_loaded` with `firebase.request_rewarded_video_status()`
			print("AdMob rewarded video status is ", data)
			
			if data["status"] == "loaded":
				admob_video_is_loaded = true
			else:
				print("no cargado")
				admob_video_is_loaded = false
	pass

func firebase_get_google_user():
	if firebase != null:
		var guser = Main.firebase.get_google_user()
	
		if guser != null:
			return parse_json(guser)
			
func debug(message, something1 = "", something2 = ""):
	if debug:
		print("[RPGElements] ", message, " ", something1, " ", something2)

func create_data_if_not_exist():
	var data = Persistence.get_data()
	
	# Existe un usuario de Google?
	var g_user = firebase_get_google_user()
	
	print("____")
	print("data: ", data)
	print(g_user)
	
	if data.empty() and g_user == null:
		var pet = pets_names[int(round(rand_range(0, pets_names.size())))]
		var pets = []
		pets.append(pet)
		
		data["Pets"] = pets
		data["Money"] = 50
		data["Points"] = 0
		data["DataVersion"] = 1
		
		Persistence.save_data()

#func firebase_send_custom(event_key, event_value):
#	if Main.firebase != null:
#		Main.firebase.send_custom(event_key, event_value)