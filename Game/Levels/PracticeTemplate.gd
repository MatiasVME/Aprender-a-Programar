extends Node

var quiz_array
var current_quiz
var current_quiz_num = 0

var lifes

func _ready():
	pass

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func next_quiz():
	if quiz_array == null:
		Main.debug("quiz_array es null")
		return
	
	if current_quiz_num != quiz_array.size():
		current_quiz = quiz_array[current_quiz_num]
		
		match quiz_array[current_quiz_num].type:
			2:
				prepare_tf(current_quiz)
				$Anim.play("tf_show")
			3:
				prepare_three_alt(current_quiz)
				$Anim.play("ta_show")
	else:
		# Finish (por el momento)
		get_tree().change_scene("res://Game/MainScreens/Credits.tscn")
		pass

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
			
			if current_quiz.type == current_quiz.TRUE_OR_FALSE:
				$Anim.play("tf_hide")
			elif current_quiz.type == current_quiz.THREE_OPTIONS:
				$Anim.play("ta_hide")
		else:
			$Questions/Result.text = "¡¡Que Mal!!"
			
			if current_quiz.type == current_quiz.TRUE_OR_FALSE:
				$Anim.play("tf_hide")
			elif current_quiz.type == current_quiz.THREE_OPTIONS:
				$Anim.play("ta_hide")

func _on_TFOpt1_pressed():
	pressed_alternative(0)

func _on_TFOpt2_pressed():
	pressed_alternative(1)

func _on_Anim_animation_finished(anim_name):
	if anim_name == "tf_hide" or anim_name == "ta_hide":
		next_quiz()

func _on_TAOpt1_pressed():
	pressed_alternative(0)

func _on_TAOpt2_pressed():
	pressed_alternative(1)

func _on_TAOpt3_pressed():
	pressed_alternative(2)
