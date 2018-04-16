extends Node

func _ready():
	$"../RPGDialog".add_section("Juanito", "Texto de prueba")
	$"../RPGDialog".add_section("Juanito", "Hola")
	$"../RPGDialog".add_section("Juanito", "Texto....")
	$"../RPGDialog".start_dialog()
