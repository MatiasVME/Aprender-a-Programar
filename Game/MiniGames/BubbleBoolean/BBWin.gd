extends Node

var ot_is_get_reward = true
var mode_str = "Fast" # Normal, Slow
var current_leaderboardID

func _ready():
	Main.reward_amount = 1
	
	MusicManager.select_music(MusicManager.WIN)
	MusicManager.play_music()
	
	match Main.bb_mode:
		Main.BBNORMAL:
			mode_str = "Normal"
		Main.BBSLOW:
			mode_str = "Slow"
	
	updated_x2()
	update_text()
	
	if Main.firebase != null:
		randomize()
		var rand_prob = int(rand_range(0,3))
		
		if rand_prob == 1:
			Main.firebase.show_interstitial_ad()
			
	if Main.data["GoogleGames"] and Main.google_games != null:
		match Main.bb_mode:
			Main.BBFAST:
				current_leaderboardID = "CgkI1raHjpUfEAIQAQ"
			Main.BBNORMAL:
				current_leaderboardID = "CgkI1raHjpUfEAIQAg"
			Main.BBSLOW:
				current_leaderboardID = "CgkI1raHjpUfEAIQAw"
	
	save_in_google_games()

func save_in_google_games():
	if Main.data["GoogleGames"] and Main.google_games != null:
		
		if Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxScore"] < Main.win_score:
			Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxScore"] = Main.win_score
		
		match Main.bb_mode:
			Main.BBFAST:
				Main.google_games.submit_leaderboard(Main.data["MiniGames"]["BubbleBool"]["Fast"]["MaxScore"], "CgkI1raHjpUfEAIQAQ")
			Main.BBNORMAL:
				Main.google_games.submit_leaderboard(Main.data["MiniGames"]["BubbleBool"]["Normal"]["MaxScore"], "CgkI1raHjpUfEAIQAg")
			Main.BBSLOW:
				Main.google_games.submit_leaderboard(Main.data["MiniGames"]["BubbleBool"]["Slow"]["MaxScore"], "CgkI1raHjpUfEAIQAw")
		
		var total_score = Main.data["Score"] + Main.win_score
		Main.google_games.submit_leaderboard(total_score, "CgkI1raHjpUfEAIQBA")

func _on_X2_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	if Main.firebase != null:
		Main.firebase.show_rewarded_video()
		
	$X2.hide()

func _on_Timer_timeout():
	updated_x2()
	
	if ot_is_get_reward and is_get_reward():
		ot_is_get_reward = false
		
		Main.win_money *= Main.reward_amount
		
		update_text()
	
func updated_x2():
	if Main.firebase != null and Main.admob_video_is_loaded and Main.reward_amount == 1:
		$X2.show()
	else:
		$X2.hide()
	
	update_text()
	
func is_get_reward():
	if Main.reward_amount > 1:
		return true
	return false
	
func update_text():
	$Data/WinScore.text = str("Puntaje Ganado: ", Main.win_score)
	$Data/WinMoney.text = str("Dinero Ganado: ", Main.win_money)
	
	if not Main.data.empty():
		# NOTE: El score no se añade en este momento, primero hay que saber
		# si el player le da al botón X2
		$Data/TotalScore.text = str("Puntaje Total: ", Main.data["Score"] + Main.win_score)
		$Data/TotalMoney.text = str("Dinero Total: ", Main.data["Money"] + Main.win_money)
		
	$Data/ComboMax.text = str("Combo Max: ", Main.bb_max_combo)
	
	var combo_record = Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxCombo"]
	if combo_record < Main.bb_max_combo:
		$Data/ComboRecord.text = str("Combo Record: ", Main.bb_max_combo)
	else:
		$Data/ComboRecord.text = str("Combo Record: ", combo_record)
		
	var max_score = Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxScore"]
	if max_score < Main.win_score:
		$Data/ScoreRecord.text = str("Puntaje Record: ", Main.win_score)
	else:
		$Data/ScoreRecord.text = str("Puntaje Record: ", max_score)

func save_all(is_continue = false):
	Main.data["Score"] += Main.win_score
	Main.data["Money"] += Main.win_money

	if Main.firebase != null:
		Main.firebase.earn_currency("Money", Main.win_money)
	
	# Guarda el record si se puede
	if Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxScore"] < Main.win_score:
		Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxScore"] = Main.win_score
	# Guarda combo maximo si se puede
	if Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxCombo"] < Main.bb_max_combo:
		Main.data["MiniGames"]["BubbleBool"][mode_str]["MaxCombo"] = Main.bb_max_combo
	
	$Timer.stop() # Para el tiempo para que no se actualice el texto
	
#	save_in_google_games()
	
	Persistence.save_data(Main.current_user)
	
func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)

	save_all()
	
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")
	
func _on_Continue_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	MusicManager.select_music(MusicManager.THEORY)
	MusicManager.play_music()
	
	$Continue.hide()
	
	save_all(true)
	
	get_tree().change_scene("res://Game/MiniGames/BubbleBoolean/BubbleBoolean.tscn")
	
func _on_Leaderboard_pressed():
	if Main.google_games != null and Main.data["GoogleGames"]:
		Main.google_games.show_leaderboard(current_leaderboardID)
	else:
		$ConfirmConnectGoogleGames.show()

func _on_ConfirmConnectGoogleGames_confirmed():
	Main.init_google_games()
	Main.data["GoogleGames"] = true
	Persistence.save_data(Main.current_user)
