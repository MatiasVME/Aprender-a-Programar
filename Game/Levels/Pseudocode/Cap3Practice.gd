extends Node

var quiz = load("res://addons/QuizNodes/Nodes/QuizMultipleChoice.gd").new()
var all_quiz = []

func _ready():
	randomize()
	quiz.name = "some" # Quiz necesita un nombre sino da error...
	
	var quiz1 = quiz.duplicate()
	
	quiz1.set_question("Los lenguajes de programación son lenguajes formales, que son ejecutados por los ordenadores.")
	quiz1.add_alternative("V", true) # Alternativa 0
	quiz1.add_alternative("F", false) # Alternativa 1 (es la correcta)
	
	all_quiz.append(quiz1)
	
	# ---
	if not Main.debug:
		var quiz2 = quiz.duplicate()
	
		quiz2.set_question("¿De forma muy sencilla, cuando escribimos por medio de un lenguaje de programación estamos?")
		quiz2.add_alternative("Hablandole al ordenador para que haga cosas.", true) # Alternativa 0
		quiz2.add_alternative("Hablandole de manera informal.", false) # Alternativa 1 (es la correcta)
		quiz2.add_alternative("Accediendo a internet", false)
		quiz2.disarray_alternatves()
	
		all_quiz.append(quiz2)
		
		# ---
		
		var quiz3 = quiz.duplicate()
	
		quiz3.set_question("Todos los lenguajes de programación son diferentes, no comparten ningúna similitud.")
		quiz3.add_alternative("V", false)
		quiz3.add_alternative("F", true)
	
		all_quiz.append(quiz3)
	
		# ---
	
		var quiz4 = quiz.duplicate()
	
		quiz4.set_question("La lógica de los lenguajes de programación es casi siempre la misma.")
		quiz4.add_alternative("V", true) 
		quiz4.add_alternative("F", false) 
	
		all_quiz.append(quiz4)
	
		# ---
	
		var quiz5 = quiz.duplicate()
	
		quiz5.set_question("¿Qué hacen los ordenadores con los programas?")
		quiz5.add_alternative("Interpretan las intrucciones del programa", true) # Alternativa 0
		quiz5.add_alternative("Lo traducen a Java", false)
		quiz5.add_alternative("Leer la instrucciónes y las interpretan ambiguamente", false)
		quiz5.disarray_alternatves()
	
		all_quiz.append(quiz5)

	# ---
	
	all_quiz.shuffle()
	
	$PracticeTemplate.add_quiz_array(all_quiz)

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "start":
		$PracticeTemplate.next_quiz()
