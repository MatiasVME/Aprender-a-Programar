extends Node

var dialog_num = 1

func _ready():
	var rpg_dialog = $TheoryTemplate/RPGDialog
	 
	var pet_name = Main.data["PetSelected"]
	
	rpg_dialog.add_section(pet_name, "Hola estimado alumno. Que bueno verlo por acá.")
	rpg_dialog.add_section(pet_name, "Primero que nada tengo que decir que este curso es para enteder la lógica de la programación y este curso no remplaza a cursos que tienen más habla.")
	rpg_dialog.add_section(pet_name, "Por lo que dejaremos muchas cosas interesantes de lado, pero no se preocupe que lo bueno de esto es que nos concentraremos en la lógica que es la párte más apacionante de la programación.")
	rpg_dialog.add_section(pet_name, "Pero eso no quiere decir que nos vamos a saltar algúnos conceptos básicos.")
	rpg_dialog.add_section(pet_name, "Hemos hablado de programación todo el tiempo, pero que significa. ¿Qué es programar?")
	rpg_dialog.add_section(pet_name, "Programar es el proceso de diseñar, codificar, depurar y mantener el código fuente de programas de computadora.")
	rpg_dialog.add_section(pet_name, "Bueno, bueno... Cuando hablamos de diseñar, nos referimos a elaborar una solución para un problema, este problema se puede solucionar de varias formas.")
	rpg_dialog.add_section(pet_name, "Hay muchas formas de solucionar un problema, en informática se usan lenguajes de programación o también lenguajes de modelado, también podemos usar pseudocódigo que es lo que haremos nosotros.")
	rpg_dialog.add_section(pet_name, "Nos concentraremos en la lógica de los lenguajes de programación, de momento no vamos a entrar en detalle acerca de los lenguajes de modelado.")
	rpg_dialog.add_section(pet_name, "Usted, estimado, sepa que existen esos lenguajes de modelado <<vease la imágen>>.")
	rpg_dialog.add_section(pet_name, "Los más conocidos son UML o lenguaje de modelado unificado y también los diagramas de flujo.")
	rpg_dialog.add_section(pet_name, "Y codificar, ¿Codificar?, amigo codificar es lo más emocionante del universo. Pero no nos apresuremos...")
	rpg_dialog.add_section(pet_name, "Cuando hablemos de codificar pensemos que es llevar la solución del problema, a código. Por ejemplo a un lenguaje de programación (ya hablaremos de ellos más adelante)")
	rpg_dialog.add_section(pet_name, "Los buenos programadores resuelven el problema primero y luego lo codifican (o lo transforman a código)")
	rpg_dialog.add_section(pet_name, "Esto, ya haciendo garabatos en un papel o utilizando lenguajes de modelado. Aunque para que estamos con cosas, si el problema es simple lo podemos codificar directamente.")
	rpg_dialog.add_section(pet_name, "¿Y depurar?, depurar es el proceso de identificar y corregir errores de programación. Muchas veces tenemos errores que corregir, las soluciones a nuestros problemas no siempre son perfectas.")
	rpg_dialog.add_section(pet_name, "Y por último cuando hablamos de mantener código [TODO]")
	rpg_dialog.add_section(pet_name, "")
	rpg_dialog.add_section(pet_name, "")
	rpg_dialog.add_section(pet_name, "")
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
	
	# Va sumando el score y dinero ganado por leer los dialogos
#	Main.win_money += Main.money_value_for_dialogue
#	Main.win_score += Main.score_value_for_dialogue

var show_times = 0

func _on_Anim_animation_finished(anim_name):
	show_times += 1
	
	if anim_name == "show" and show_times == 2:
		$TheoryTemplate/Anim.play("finish")
	elif anim_name == "finish":
		if Main.data["PseudocodePastsLevels"] == 2:
			Main.data["PseudocodePastsLevels"] += 1
			Persistence.save_data(Main.current_user)
			
		get_tree().change_scene("res://Game/Levels/Win.tscn")
