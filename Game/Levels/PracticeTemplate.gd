extends Node

var quiz_array
var current_quiz
var current_quiz_num = 0

var lifes = 1 # Por defecto es 1

var ot_continue = true

var is_game_over = false

func _ready():
	randomize()
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(false)
	
	var prob = int(round(rand_range(0, 5)))
	
	# Interstitial
	if prob <= 1 and Main.firebase != null:
		Main.firebase.show_interstitial_ad()
		
	if Main.current_chapter == null:
		Main.current_chapter = 2
		

func _on_Back_pressed():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func next_quiz():
	if quiz_array == null:
		Main.debug("quiz_array es null")
		return
	
	if current_quiz_num != quiz_array.size() and lifes > 0:
		current_quiz = quiz_array[current_quiz_num]
		
		match quiz_array[current_quiz_num].type:
			2:
				prepare_tf(current_quiz)
				$Anim.play("tf_show")
			3:
				prepare_three_alt(current_quiz)
				$Anim.play("ta_show")
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
	
func pressed_alternative(alternative):
	if current_quiz != null:
		current_quiz.select_answer(alternative)
		
		if current_quiz.get_result():
			$Questions/Result.text = "¡¡Muy Bien!!"
			
			var cap = str("Cap", Main.current_chapter)
			# Va sumando el score y dinero ganado por leer los dialogos
			Main.win_money += Main.data["Chapters"][cap]["MoneyValueForAnswer"]
			Main.win_score += Main.data["Chapters"][cap]["ScoreValueForAnswer"]
			
			if current_quiz.type == current_quiz.TRUE_OR_FALSE:
				$Anim.play("tf_hide")
			elif current_quiz.type == current_quiz.THREE_OPTIONS:
				$Anim.play("ta_hide")
		else:
			$Questions/Result.text = "¡¡Que Mal!!"
			
			lifes -= 1
			
			if current_quiz.type == current_quiz.TRUE_OR_FALSE:
				$Anim.play("tf_hide")
			elif current_quiz.type == current_quiz.THREE_OPTIONS:
				$Anim.play("ta_hide")

func finish():
	if Main.firebase != null:
		# Saber si se puede ver un reward video
		if Main.admob_video_is_loaded and Main.reward_amount == 1 and lifes == 0 and ot_continue:
			ot_continue = false
			
			$Anim.play("continue_show")
		elif Main.current_chapter != 1:
			# Hacer que salga un interstitial al principio
#			Main.firebase.show_interstitial_ad()
			
			if lifes > 0:
				get_tree().change_scene("res://Game/Levels/Win.tscn")
			else:
				get_tree().change_scene("res://Game/Levels/Lost.tscn")
	else:
		if lifes > 0:
			get_tree().change_scene("res://Game/Levels/Win.tscn")
		else:
			if Main.firebase != null:
				Main.firebase.show_interstitial_ad()
			
			get_tree().change_scene("res://Game/Levels/Lost.tscn")

func _on_TFOpt1_pressed():
	pressed_alternative(0)

func _on_TFOpt2_pressed():
	pressed_alternative(1)

func _on_Anim_animation_finished(anim_name):
	if anim_name == "tf_hide" or anim_name == "ta_hide":
		next_quiz()
	elif anim_name == "finish":
		finish()

func _on_TAOpt1_pressed():
	pressed_alternative(0)

func _on_TAOpt2_pressed():
	pressed_alternative(1)

func _on_TAOpt3_pressed():
	pressed_alternative(2)
