extends Node

var quiz = load("res://addons/QuizNodes/Nodes/QuizMultipleChoice.gd").new()
var all_quiz = []

func _ready():
	var quiz1 = quiz.duplicate()
	
	quiz1.set_question("Programar es el proceso de diseñar, codificar, depurar y mantener código fuente.")
	quiz1.add_alternative("V", true) # Alternativa 0
	quiz1.add_alternative("F", false) # Alternativa 1 (es la correcta)
	quiz1.disarray_alternatves()
	
	all_quiz.append(quiz1)
	
	# ---
	
#	var quiz2 = quiz.duplicate()
#
#	quiz2.set_question("¿Cuál de las siguientes actividades no es considerada parte de la programación?")
#	quiz2.add_alternative("Codificar", false) # Alternativa 0
#	quiz2.add_alternative("Depurar", false) # Alternativa 1 (es la correcta)
#	quiz2.add_alternative("Motivar al equipo", true)
#	quiz2.disarray_alternatves()
#
#	all_quiz.append(quiz2)
	
	# ---
	
#	var quiz3 = quiz.duplicate()
#
#	quiz3.set_question("¿Cuándo hablamos de diseñar a que nos referimos?")
#	quiz3.add_alternative("A elaborar una solución a un problema", true) # Alternativa 0
#	quiz3.add_alternative("A testiar el producto de software", false)
#	quiz3.add_alternative("A escribir código binario", false)
#	quiz3.disarray_alternatves()
#
#	all_quiz.append(quiz3)
#
	# ---
	
	var quiz4 = quiz.duplicate()
	
	quiz4.set_question("Codificar es llevar la solución del problema a UML")
	quiz4.add_alternative("F", true) # Alternativa 0
	quiz4.add_alternative("V", false) # Alternativa 1 (es la correcta)
	quiz4.disarray_alternatves()
	
	all_quiz.append(quiz4)
	
	# ---
	
	all_quiz.shuffle()
	
	$PracticeTemplate.add_quiz_array(all_quiz)
	
#	$Question.text = $TrueOrFalse.get_question()
#	$True.text = $TrueOrFalse.get_alternative(0)
#	$False.text = $TrueOrFalse.get_alternative(1)

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "start":
		print("next")
		$PracticeTemplate.next_quiz()
