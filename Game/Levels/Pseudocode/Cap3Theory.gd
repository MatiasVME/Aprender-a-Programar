extends Node

var dialog_num = 1

func _ready():
	if Main.current_chapter == null:
		Main.current_chapter = 3
		
	if not Main.data["Chapters"].has("Cap3"):
		Main.data["Chapters"]["Cap3"] = {
			ScoreValueForDialogue = 3,
			MoneyValueForDialogue = 3,
			ScoreValueForAnswer = 5,
			MoneyValueForAnswer = 5,
			TheoryCompleted = false, # debe estar en false
			PracticeCompleted = false
		}
		
		Persistence.save_data(Main.current_user)
	
	var rpg_dialog = $TheoryTemplate/RPGDialog

	var pet_name = Main.data["PetSelected"]

	rpg_dialog.add_section(pet_name, "Hola estimado, sabía que volverías. ¿Cómo has estado? Bueno espero que bien.")
	
	if not Main.debug:
		rpg_dialog.add_section(pet_name, "Hoy hablaremos sobre los leguajes de programación. ¿Qué son?, ¿Para qué sirven?")
		rpg_dialog.add_section(pet_name, "Entonces diremos que: Un lenguaje de programación es un lenguaje formal que especifica una serie de instrucciones para que una computadora produzca diversas clases de datos.")
		rpg_dialog.add_section(pet_name, "De forma mas sencilla, podríamos decir que, es una forma en la cúal nosotros le hablamos a la computadora para que ejecute instrucciones.")
		rpg_dialog.add_section(pet_name, "Pero nosotros no le podemos hablar como nosotros queramos, no, no, no. Sino que tendrémos que hablarle de una formá específica, con palabras bien definidas y que el ordenador pueda entender.")
		rpg_dialog.add_section(pet_name, "Esto es por medio de un leguaje de programación, a la derecha vemos a Java por ejemplo.")
		rpg_dialog.add_section(pet_name, "Otro  sería Ruby.")
		rpg_dialog.add_section(pet_name, "Los lenguajes pueden ser distintos pero siempre o casi siempre, se mantiene algo. Y eso amigo, es la lógica de la programación.")
		rpg_dialog.add_section(pet_name, "Muchos, aunque no todos, comparten la misma lógica. Y si amprendemos la lógica podremos saltar de un lenguaje a otro sin muchas complicaciones.")
		rpg_dialog.add_section(pet_name, "Los lenguajes de programación se usan para crear programas que puede interpretar o entender un computador.")
		rpg_dialog.add_section(pet_name, "Siempre lo hacemos por medio de algoritmos. Ok... ¿Algoritmo? ¿Dirás, que quise decir Algo con Ritmo?... No, no, amigo dije bien.. Algoritmo.")
		rpg_dialog.add_section(pet_name, "Eso lo dejaremos para el próximo capítulo, a cualquier hora, en el mismo canal.")
		rpg_dialog.add_section(pet_name, "Por ahora eso es todo, nos vemos.")
		
	rpg_dialog.start_dialog()
	
	$AnyPet.walk()
	dialog_num += 1
	
func _on_RPGDialog_changed_text():
	print("dialog_num: ", dialog_num)
	
	if $Anim.has_animation(str("anim", dialog_num)):
		$Anim.play(str("anim", dialog_num))
	
	match dialog_num:
		2:
			$AnyPet.talk()
			
	dialog_num += 1

func _on_Anim_animation_finished(anim_name):
	if anim_name == "finish":
		get_tree().change_scene("res://Game/Levels/Win.tscn")
