extends Node

func _ready():
	var rpg_dialog = $TheoryTemplate/RPGDialog
	
	rpg_dialog.add_section("Juanito", "Texto de prueba")
	rpg_dialog.add_section("Juanito", "Hola")
	rpg_dialog.add_section("Juanito", "Texto....")
	rpg_dialog.start_dialog()
