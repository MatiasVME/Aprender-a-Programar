extends Node

const RES_X = 1280
const RES_Y = 720

var version = "v1.3.3"
var music_enable = true
var sound_enable = true

var debug = false

var pseudocode_max_level = 1

var firebase
var google_user
var google_games

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

# Mini-Games
#

# BubbleBool
var bb_max_combo = 0
# usa win_score y win_money
enum BBMode {BBFAST, BBNORMAL, BBSLOW}
var bb_mode = BBMode.BBFAST

var data
const DATA_VERSION = 4

# Google Games
var ot_google_games = true

func _ready():
	randomize()

	# Para tests
	if debug:
#		Persistence.remove_all_data()
		Persistence.mode = Persistence.MODE_TEXT
	else:
		Persistence.mode = Persistence.MODE_ENCRYPTED
		Persistence.debug = false
		
	data = Persistence.get_data(current_user)

	# Tiene data version
	if data.has("DataVersion"):
		if data["DataVersion"] != DATA_VERSION:
			Persistence.remove_all_data()
			
			data["DataVersion"] = DATA_VERSION
			Persistence.save_data(current_user)
			
			get_tree().quit()
		else:
			if not data.has("AcceptPrivacyPolicy"):
				data["AcceptPrivacyPolicy"] = false
			else:
				all_data_config()
	# No hay data version es un nuevo usuario
	else:
		data["DataVersion"] = DATA_VERSION
		
		if not data.has("AcceptPrivacyPolicy"):
			data["AcceptPrivacyPolicy"] = false
		elif data["AcceptPrivacyPolicy"] == true:
			all_data_config()
	
	Persistence.save_data(current_user)
	
func reset_values():
	win_score = 0
	win_money = 0
	reward_amount = 1
	lifes = 1

func init_google_games():
	if OS.get_name() == "Android":
		google_games = Engine.get_singleton("GooglePlay")
		google_games.init(get_instance_id())

func reset_bb():
	reset_values()
	
	bb_max_combo = 0

func all_data_config():
	firebase_config()
	
	create_data_if_not_exist()
	
	# Para las versiones que no tienen GoogleGames
	# se crea un google games
	if data.has("GoogleGames"):
		if data["AcceptPrivacyPolicy"] and data["GoogleGames"]:
			init_google_games()
	else:
		data["GoogleGames"] = false
		Persistence.save_data(Main.current_user)

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
	
	if from == "GooglePlay":
		debug("[Debug] Key: ", key, " Data: ", data)
		
		if google_games != null and ot_google_games:
			ot_google_games = false
			

func firebase_get_google_user():
	if firebase != null:
		var guser = firebase.get_google_user()
	
		if guser != null:
			return parse_json(guser)
			
func debug(message, something1 = "", something2 = ""):
	if debug:
		print("[AAP] ", message, " ", something1, " ", something2)

func create_data_if_not_exist():
	if not data.has("Pets"):
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
		data["MiniGames"] = {
			BubbleBool = {
				# Un minuto
				Fast = {
					MaxCombo = 0,
					MaxScore = 0
				},
				# Normal
				Normal = {
					MaxCombo = 0,
					MaxScore = 0
				},
				# Slow
				Slow = {
					MaxCombo = 0,
					MaxScore = 0
				}
			}
		}
		data["GoogleGames"] = false
		
		Persistence.save_data(current_user)
		