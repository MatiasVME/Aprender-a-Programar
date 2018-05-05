extends Node

const RES_X = 1280
const RES_Y = 720

var version = "v1.2.0"
var music_enable = true
var sound_enable = true

var debug = false

var pseudocode_max_level = 1

var firebase
var google_user

# User
var current_user = null

# Rewards
var admob_video_is_loaded = false
var reward_amount = 1

# Score and money
var win_score = 0
var win_money = 0

# Practice
var lifes = 1

# Chapters
var current_chapter
enum CurrentStage {THEORY, PRACTICE}
var current_stage = -1

# Pets (Kripo ya no)
var pets_names = ["Pipo", "Stuar", "Posholo", "Cato"]

var data
const DATA_VERSION = 2

func _ready():
	randomize()

	# Para tests
	if debug:
		Persistence.remove_all_data()
		pass
	
	Persistence.mode = Persistence.MODE_ENCRYPTED
	data = Persistence.get_data(Main.current_user)
	
	debug(OS.get_user_data_dir())
	
	firebase_config()
	firebase_auth_config()
	google_user = firebase_get_google_user()
	
	create_data_if_not_exist()
	
	# Borra toda la data si no esta a la misma versión de data
	if data["DataVersion"] != DATA_VERSION:
		Persistence.remove_all_data()
		get_tree().quit()

func reset_values():
	win_score = 0
	win_money = 0
	reward_amount = 1
	lifes = 1

func firebase_config():
	if OS.get_name() == "Android":
		firebase = Engine.get_singleton("FireBase")
		var file = File.new()
		file.open("res://godot-firebase-config.json", file.READ)
		var config = file.get_as_text()
		file.close()
		
		firebase.init(config, get_instance_id())

func firebase_auth_config():
	if firebase != null:
		firebase.authConfig("'Google':true,'Facebook':true")
	
func _receive_message(tag, from, key, data):
	if tag == "FireBase" and from == "AdMob":
		if key == "AdMobReward":
			# when rewared video play complete
			debug("json data with [RewardType & RewardAmount]: ", data)
			reward_amount = data["RewardAmount"]
			lifes += reward_amount - 1
			
		elif key == "AdMob_Video":
			# when rewarded video loaded
			# data will be `loaded` or `load_failed and `loaded` or `not_loaded` with `firebase.request_rewarded_video_status()`
			debug("AdMob rewarded video status is ", data)
			
			if data["status"] == "loaded":
				admob_video_is_loaded = true
			else:
				debug("no cargado")
				admob_video_is_loaded = false
		
	if tag == "FireBase" and from == "Auth":
		if key == "GoogleLogin" && data == "true":
			current_user = firebase_get_google_user()["name"]
			self.data = Persistence.get_data(current_user)
			create_data_if_not_exist()

func firebase_get_google_user():
	if firebase != null:
		var guser = Main.firebase.get_google_user()
	
		if guser != null:
			return parse_json(guser)
			
func debug(message, something1 = "", something2 = ""):
	if debug:
		print("[AAP] ", message, " ", something1, " ", something2)

func create_data_if_not_exist():
	if data.empty():
		var rand_pet = int(round(rand_range(0, pets_names.size() - 1)))
		var pet = pets_names[rand_pet]
		var pets = []
		pets.append(pet)
		
		data["DataVersion"] = DATA_VERSION
		data["Pets"] = pets
		data["PetSelected"] = pet
		data["Money"] = 0
		data["Score"] = 0
		data["PseudocodePastsLevels"] = 1 # debe estar en 1
		data["Chapters"] = {
			Cap1 = {
				ScoreValueForDialogue = 3,
				MoneyValueForDialogue = 3,
				TheoryCompleted = false,
				PracticeCompleted = true
			}
		}
		
		Persistence.save_data(current_user)
		