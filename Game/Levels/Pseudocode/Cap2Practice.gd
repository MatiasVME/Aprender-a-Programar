extends Node

var quiz = load("res://addons/QuizNodes/Nodes/QuizMultipleChoice.gd").new()
var all_quiz = []

func _ready():
	randomize()
	
	var quiz1 = quiz.duplicate()
	
	quiz1.set_question("Programar es el proceso de codificar, depurar y mantener código fuente.")
	quiz1.add_alternative("V", true) # Alternativa 0
	quiz1.add_alternative("F", false) # Alternativa 1 (es la correcta)
	
	all_quiz.append(quiz1)
	
	# ---
	
	var quiz2 = quiz.duplicate()

	quiz2.set_question("¿Cuál de las siguientes actividades no es considerada parte de la programación?")
	quiz2.add_alternative("Codificar", false) # Alternativa 0
	quiz2.add_alternative("Depurar", false) # Alternativa 1 (es la correcta)
	quiz2.add_alternative("Motivar al equipo", true)
	quiz2.disarray_alternatves()

	all_quiz.append(quiz2)
	
	# ---
	
	var quiz3 = quiz.duplicate()

	quiz3.set_question("¿Qué es codificar?")
	quiz3.add_alternative("Llevar la solución del problema a código", true) # Alternativa 0
	quiz3.add_alternative("Testear el producto de software", false)
	quiz3.add_alternative("Escribir en el teclado", false)
	quiz3.disarray_alternatves()

	all_quiz.append(quiz3)

	# ---

	var quiz4 = quiz.duplicate()

	quiz4.set_question("Codificar es llevar la solución del problema a UML")
	quiz4.add_alternative("V", false) 
	quiz4.add_alternative("F", true) 

	all_quiz.append(quiz4)

	# ---

	var quiz5 = quiz.duplicate()

	quiz5.set_question("¿Qué es depurar?")
	quiz5.add_alternative("Identificar y corregir errores de programación", true) # Alternativa 0
	quiz5.add_alternative("Hacer diagramas de el problema", false)
	quiz5.add_alternative("Testear y hacer diagramas de el problema", false)
	quiz5.disarray_alternatves()

	all_quiz.append(quiz5)

	# ---

	var quiz6 = quiz.duplicate()

	quiz6.set_question("Mantener es la modificación de un producto de software -antes- de la entrega")
	quiz6.add_alternative("V", false) 
	quiz6.add_alternative("F", true) 

	all_quiz.append(quiz6)

	# --- para corregir errores, mejorar el rendimiento, u otros atributos

	var quiz7 = quiz.duplicate()

	quiz7.set_question("¿Cuál de estas actividades no implica mantener código fuente?")
	quiz7.add_alternative("Preparar café", true) # Alternativa 0
	quiz7.add_alternative("Corregir errores", false)
	quiz7.add_alternative("Mejorar el rendimiento", false)
	quiz7.disarray_alternatves()

	all_quiz.append(quiz7)

	# ---
	
	all_quiz.shuffle()
	
	$PracticeTemplate.add_quiz_array(all_quiz)

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "start":
		$PracticeTemplate.next_quiz()
