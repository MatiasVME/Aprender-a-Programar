extends Node

var quiz_array
var current_quiz
var current_quiz_num = 0

var ot_continue = true

var is_game_over = false
var get_reward = false

var times_wait_for_lifes = 0

func _ready():
	randomize()
	Main.reset_values()
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(false)
	
	$ContinuePanel.connect("ok", self, "on_ok_panel")
	$ContinuePanel.connect("exit", self, "on_exit_panel")

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func next_quiz():
	if quiz_array == null:
		Main.debug("quiz_array es null")
		return
		
	if not current_quiz_num >= quiz_array.size() and Main.lifes > 0:
		current_quiz = quiz_array[current_quiz_num]
		
		print(quiz_array)
		
		if typeof(quiz_array[current_quiz_num]) == TYPE_OBJECT:
			match quiz_array[current_quiz_num].type:
				2:
					prepare_tf(current_quiz)
					$Anim.play("tf_show")
				3:
					prepare_three_alt(current_quiz)
					$Anim.play("ta_show")
		elif typeof(quiz_array[current_quiz_num]) == TYPE_DICTIONARY:
			if quiz_array[current_quiz_num]["Type"] == "BuildLine4":
				prepare_build_line_4(quiz_array[current_quiz_num])
				$Anim.play("bl4_show")
	else:
		# Finish
		$Anim.stop()
		$Anim.play("finish")
		
	current_quiz_num += 1

func add_quiz_array(_quiz_array):
	quiz_array = _quiz_array
	
# Prepare true or false
func prepare_tf(quiz):
	$Questions/TF/TFOpt1/Text.text = quiz.get_alternative(0)
	$Questions/TF/TFOpt2/Text.text = quiz.get_alternative(1)
	$Questions/Question.text = quiz.get_question()
	
# Prepare three alternatives
func prepare_three_alt(quiz):
	$Questions/ThreeAlt/TAOpt1/Text.text = quiz.get_alternative(0)
	$Questions/ThreeAlt/TAOpt2/Text.text = quiz.get_alternative(1)
	$Questions/ThreeAlt/TAOpt3/Text.text = quiz.get_alternative(2)
	$Questions/Question.text = quiz.get_question()

func prepare_build_line_4(dict):
	$Questions/Question.text = dict["Question"]
	
	var build_line = $Questions/BuildLine/BuildLine4
	var word1 = dict["Line"]["1"]
	var word2 = dict["Line"]["2"]
	var word3 = dict["Line"]["3"]
	var word4 = dict["Line"]["4"]
	
	build_line.reset()
	build_line.add_sort_line(word1, word2, word3, word4)
	build_line.disorder()
	build_line.set_up_slots_and_items()

func pressed_alternative(alternative):
	if current_quiz != null:
		current_quiz.select_answer(alternative)
		
		if current_quiz.get_result():
			win_question(current_quiz)
		else:
			lost_question(current_quiz)

func win_question(current_quiz):
	SoundManager.select_sound(SoundManager.CORRECT)
	SoundManager.play_sound()
	
	$Questions/Result.text = "¡¡Muy Bien!!"
			
	var cap = str("Cap", Main.current_chapter)
	# Va sumando el score y dinero ganado por leer los dialogos
	Main.win_money += Main.data["Chapters"][cap]["MoneyValueForAnswer"]
	Main.win_score += Main.data["Chapters"][cap]["ScoreValueForAnswer"]

	hide_question(current_quiz)

func lost_question(current_quiz):
	SoundManager.select_sound(SoundManager.INCORRECT)
	SoundManager.play_sound()
	
	$Questions/Result.text = "¡¡Que Mal!!"
	
	Main.lifes -= 1
	
	hide_question(current_quiz)

func hide_question(current_quiz):
	if typeof(current_quiz) == TYPE_OBJECT:
		if current_quiz.type == current_quiz.TRUE_OR_FALSE:
			$Anim.play("tf_hide")
		elif current_quiz.type == current_quiz.THREE_OPTIONS:
			$Anim.play("ta_hide")
	elif typeof(current_quiz) == TYPE_DICTIONARY:
		if current_quiz["Type"] == "BuildLine4":
			$Anim.play("bl4_hide")

func finish():
	if Main.firebase != null:
		# Saber si se puede ver un reward video
		if Main.admob_video_is_loaded and Main.reward_amount == 1 and Main.lifes == 0 and ot_continue:
			ot_continue = false
			
			$Anim.play("continue_show")
		elif Main.current_chapter != 1:
			if Main.lifes > 0:
				Main.firebase.show_interstitial_ad()
				
				get_tree().change_scene("res://Game/Levels/Win.tscn")
			else:
				Main.firebase.show_interstitial_ad()
				
				get_tree().change_scene("res://Game/Levels/Lost.tscn")
	else:
		if Main.lifes > 0:
			get_tree().change_scene("res://Game/Levels/Win.tscn")
		else:
			get_tree().change_scene("res://Game/Levels/Lost.tscn")

func configure_practice(all_quiz):
	var quiz_object = load("res://addons/QuizNodes/Nodes/QuizMultipleChoice.gd").new()
	quiz_object.name = "some"
	
	var file = File.new()
	file.open("res://Game/Content.json", file.READ)
	var content = parse_json(file.get_as_text())
	file.close()
	
	for i in content["Pseudocode"]["Chapters"][str(Main.current_chapter)]["Practice"]:
		var quiz = quiz_object.duplicate()
		var dict = content["Pseudocode"]["Chapters"][str(Main.current_chapter)]["Practice"][i]

		if dict["Type"] == "TrueOrFalse":
			quiz.set_question(dict["Question"])
			quiz.add_alternative(dict["Options"]["1"], int(dict["CorrectAnswer"]) == 1)
			quiz.add_alternative(dict["Options"]["2"], int(dict["CorrectAnswer"]) == 2) 
			
			all_quiz.append(quiz)

		elif dict["Type"] == "ThreeOptions":
			quiz.set_question(dict["Question"])
			quiz.add_alternative(dict["Options"]["1"], int(dict["CorrectAnswer"]) == 1)
			quiz.add_alternative(dict["Options"]["2"], int(dict["CorrectAnswer"]) == 2)
			quiz.add_alternative(dict["Options"]["3"], int(dict["CorrectAnswer"]) == 3)
			quiz.disarray_alternatves()
			
			all_quiz.append(quiz)
			
		elif dict["Type"] == "BuildLine4":
			all_quiz.append(dict)

func _on_TFOpt1_pressed():
	pressed_alternative(0)

func _on_TFOpt2_pressed():
	pressed_alternative(1)

func _on_Anim_animation_finished(anim_name):
	if anim_name == "tf_hide" or anim_name == "ta_hide" or anim_name == "bl4_hide":
		next_quiz()
	elif anim_name == "finish":
		finish()

func _on_TAOpt1_pressed():
	pressed_alternative(0)

func _on_TAOpt2_pressed():
	pressed_alternative(1)

func _on_TAOpt3_pressed():
	pressed_alternative(2)
	
func on_ok_panel():
	if Main.firebase != null and not get_reward:
		Main.firebase.show_rewarded_video()
		get_reward = true
		$WaitForLifes.start()
	
func on_exit_panel():
	$Anim.stop()
	$Anim.play("finish")

func _on_WaitForLifes_timeout():
	times_wait_for_lifes += 1
	
	if Main.lifes > 0:
		print("next_quiz(), lifes", Main.lifes)
		$WaitForLifes.stop()
		next_quiz()
	elif times_wait_for_lifes == 7:
		$WaitForLifes.stop()
		$Anim.play("finish")

func _on_Finish_pressed():
	if $Questions/BuildLine/BuildLine4.is_correct():
		win_question(current_quiz)
	else:
		lost_question(current_quiz)
