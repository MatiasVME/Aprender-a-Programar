extends Node

func _ready():
	if Main.current_user == null:
		$User.text = str("Usuario: Predeterminado")
	else:
		$User.text = str("Usuario: ", Main.current_user)
	
	$Money.text = str("Dinero: ", Main.data["Money"])
	$Score.text = str("Puntaje: ", Main.data["Score"])
	$YourPets.text = str("Mascotas: ", Main.data["Pets"])

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Awards.tscn")
