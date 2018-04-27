extends Node


var all_quiz = []

func _ready():
	randomize()
	
	if Main.current_chapter == null:
		Main.current_chapter = 4
#	quiz.name = "some" # Quiz necesita un nombre sino da error...
	
#	var quiz1 = quiz.duplicate()
#
#	quiz1.set_question("Los lenguajes de programación son lenguajes formales, que son ejecutados por los ordenadores.")
#	quiz1.add_alternative("V", true) # Alternativa 0
#	quiz1.add_alternative("F", false) # Alternativa 1 (es la correcta)
#
#	all_quiz.append(quiz1)
	$PracticeTemplate.get_all_quiz(all_quiz)

	all_quiz.shuffle()
	
	$PracticeTemplate.add_quiz_array(all_quiz)

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "start":
		$PracticeTemplate.next_quiz()
