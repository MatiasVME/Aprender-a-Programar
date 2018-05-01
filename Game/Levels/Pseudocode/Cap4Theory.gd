extends Node

var dialog_num = 1

func _ready():
	if Main.current_chapter == null:
		Main.current_chapter = 4
		
	if not Main.data["Chapters"].has("Cap4"):
		Main.data["Chapters"]["Cap4"] = {
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

	rpg_dialog.add_section(pet_name, "Hola, amigo, espero que estés bien.")
	
	if not Main.debug:
		rpg_dialog.add_section(pet_name, "La clase pasada hablamos sobre los leguajes de programación. Recordemos que, de forma simple, un lenguaje de programación es una forma de hablarle al ordenador.")
		rpg_dialog.add_section(pet_name, "Debemos de hablarle de una forma específica, para que nos pueda entender. Esto es por medio de un algoritmo.")
		rpg_dialog.add_section(pet_name, "Bueno, entonces, ¿Qué diantres es un algoritmo? Se dice que...")
		rpg_dialog.add_section(pet_name, "Es un conjunto prescrito de instrucciones o reglas bien definidas, ordenadas y finitas que permite llevar a cabo una actividad mediante pasos sucesivos que no generen dudas a quien deba hacer dicha actividad.")
		rpg_dialog.add_section(pet_name, "Entonces las características de los algoritmos son que: Tiene reglas bien definidas, son ordenadas, son finitas, permiten llevar a cabo una actividad, no generan dudas.")
		rpg_dialog.add_section(pet_name, "Entonces ¿Los algorítmos podrian existir en la vida real?, ¡Claro que sí! Solo se tiene que cumplir las características antes mencionadas.")
		rpg_dialog.add_section(pet_name, "Tenemos diferentes formas de expresar un algoritmo. Podemos hacerlo por medio de un leguaje de programación, también por pseudocódigo y también por diagramas de flujo.")
		rpg_dialog.add_section(pet_name, "Por ejemplo, este que tenemos a la derecha es un diagrama de flujo. ¡Y es un algoritmo!")
		rpg_dialog.add_section(pet_name, "A la derecha vemos un ejemplo en pseudocódigo. Es lo que estaremos utilzando normalmente. Pero por ahora pasaremos de el.")
		rpg_dialog.add_section(pet_name, "Bueno amigo eso es todo, nos veremos pronto.")
	
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
