extends Node

var ot_is_get_reward = true

func _ready():
	Main.reward_amount = 1
	
	MusicManager.select_music(MusicManager.WIN)
	MusicManager.play_music()
	
	updated_x2()
	update_text()

func _on_X2_pressed():
	if Main.firebase != null:
		Main.firebase.show_rewarded_video()
		
	$X2.hide()

func _on_Timer_timeout():
	updated_x2()
	
	if ot_is_get_reward and is_get_reward():
		ot_is_get_reward = false
		
		Main.win_money *= Main.reward_amount
		Main.win_score *= Main.reward_amount
		
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
	$WinScore.text = str("Puntaje Ganado: ", Main.win_score)
	$WinMoney.text = str("Dinero Ganado: ", Main.win_money)
	
	if not Main.data.empty():
		# NOTE: El score no se añade en este momento, primero hay que saber
		# si el player le da al botón X2
		$TotalScore.text = str("Puntaje Total: ", Main.data["Score"] + Main.win_score)
		$TotalMoney.text = str("Dinero Total: ", Main.data["Money"] + Main.win_money)

func save_all():
	Main.data["Score"] += Main.win_score
	Main.data["Money"] += Main.win_money
	
	Persistence.save_data(Main.current_user)

	if Main.firebase != null:
		Main.firebase.earn_currency("Money", Main.win_money)

func _on_Back_pressed():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
		
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()
	
	save_all()
	
	var practice_completed = Main.data["Chapters"][str("Cap", Main.current_chapter)]["PracticeCompleted"]
	if practice_completed:
		Main.current_chapter += 1
	
	Main.data["Chapters"][str("Cap", Main.current_chapter)]["TheoryCompleted"] = true
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")
	
func _on_Continue_pressed():
	$Continue.hide()
	
	save_all()
	
	var practice_completed = Main.data["Chapters"][str("Cap", Main.current_chapter)]["PracticeCompleted"]
	if practice_completed:
		Main.current_chapter += 1
	
	$Timer.stop() # Para el tiempo para que no se actualice el texto
	
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()
	
	if Main.current_stage == Main.THEORY and Main.current_chapter != 1:
		Main.current_stage = Main.PRACTICE
		var scene_path = str("res://Game/Levels/Pseudocode/Cap", Main.current_chapter, "Theory.tscn")
		get_tree().change_scene(scene_path)
	else:
		Main.current_satage = Main.Theory
		var scene_path = str("res://Game/Levels/Pseudocode/Cap", Main.current_chapter, "Practice.tscn")
		get_tree().change_scene(scene_path)
		

	
	
	
	
	
	
	
	
	
	
	
	
	