extends Node

var dialog_num = 1

func _ready():
	if Main.current_chapter == null:
		Main.current_chapter = 2
	
	if not Main.data["Chapters"].has("Cap2"):
		Main.data["Chapters"]["Cap2"] = {
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
	
	rpg_dialog.add_section(pet_name, "Hola estimado alumno. Que bueno verlo por acá.")
	
	if not Main.debug:
		rpg_dialog.add_section(pet_name, "Primero que nada tengo que decir que este curso es para enteder la lógica de la programación y este curso no remplaza a cursos que tienen más habla.")
		rpg_dialog.add_section(pet_name, "Por lo que dejaremos muchas cosas interesantes de lado, pero no se preocupe que lo bueno de esto es que nos concentraremos en la lógica que es la párte más apasionante de la programación.")
		rpg_dialog.add_section(pet_name, "Pero eso no quiere decir que nos vamos a saltar algúnos conceptos básicos.")
		rpg_dialog.add_section(pet_name, "Hemos hablado de programación todo el tiempo, pero que significa. ¿Qué es programar?")
		rpg_dialog.add_section(pet_name, "Programar es el proceso de codificar, depurar y mantener el código fuente de programas de computadora.")
		rpg_dialog.add_section(pet_name, "Codificar, ¿Codificar?, ¡Amigo codificar es lo más emocionante del universo!. Pero no nos apresuremos...")
		rpg_dialog.add_section(pet_name, "Cuando hablemos de codificar pensemos que es llevar la solución del problema, a código. Por ejemplo a un lenguaje de programación (ya hablaremos de ellos más adelante)")
		rpg_dialog.add_section(pet_name, "Los buenos programadores resuelven el problema primero y luego lo codifican (o lo transforman a código)")
		rpg_dialog.add_section(pet_name, "Eso, ya haciendo garabatos en un papel o utilizando lenguajes de diagramas como UML. Aunque para que estamos con cosas, si el problema es simple lo podemos codificar directamente.")
		rpg_dialog.add_section(pet_name, "Amigo, puede que no hablemos de UML. Pero sepa usted que UML o lenguaje de modelado unificado, se utiliza mucho para crear sistemas grandes. Puede ver una referencia a la derecha de un diagrama hecho con UML.")
		rpg_dialog.add_section(pet_name, "¿Y qué es depurar?, depurar es el proceso de identificar y corregir errores de programación. Muchas veces tenemos errores que corregir, las soluciones a nuestros problemas no siempre son perfectas.")
		rpg_dialog.add_section(pet_name, "Y por último cuando hablamos de mantener código nos referimos a la modificación de un producto de software después de la entrega, para corregir errores, mejorar el rendimiento, u otros atributos.")
		rpg_dialog.add_section(pet_name, "Bueno estimado eso es todo por ahora, veamos que a aprendido en la parte práctica. Nos vemos.")
		
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
