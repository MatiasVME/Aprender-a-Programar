extends Node

var dialog_num = 1

func _ready():
	var rpg_dialog = $TheoryTemplate/RPGDialog
	rpg_dialog.add_section("Stuar", "Hola ¿Qué tal? Estimado alumno. Yo seré tu estimado profesor de programación... ¿Qué?, ¿Que tiene de malo ser como soy?")
	rpg_dialog.add_section("Stuar", "Este apartado es para explicarle como va el tema, de esta aplicación.")
	rpg_dialog.add_section("Stuar", "Bueno y me presento, soy Stuar. Aunque ya ves mi nombre sale arriba de la pantalla.")
	rpg_dialog.add_section("Stuar", "Hoy es un gran día, porque hoy es el inicio de tu formación como programador y también es el inicio de nuestra amistad.")
	rpg_dialog.add_section("Stuar", "La idea de este curso es, hacer la programación lo más fácil de entender posible y también de una forma muy agradable.")
	rpg_dialog.add_section("Stuar", "Para eso utilizaremos un pseudolenguaje de programacion inventado por mi, que recolecta las estructuras básicas de la programación.")
	rpg_dialog.add_section("Stuar", "Bueno, este capitulo es solo para presentarme y decir un poco como va el tema acá.")
	rpg_dialog.add_section("Stuar", "Normalmente verás una parte teórica y otra parte práctica, en la parte teoríca me verás a mi hablando cosas y en la parte práctica, podremos a prueba lo estudidado.")
	rpg_dialog.add_section("Stuar", "Si quieres puedes pasarte por la tienda y comprar nuevos profesores, pero yo siempre seré el mejor. Y no te preocupes que nos compran con dinero de juego.")
	rpg_dialog.start_dialog()
	
	$AnyPet.walk()
	dialog_num += 1

func _on_RPGDialog_changed_text():
	$Anim.play(str("anim", dialog_num))
	
	match dialog_num:
		2:
			$AnyPet.talk()
			
	dialog_num += 1
