extends Node

var data

func _ready():
	data = Persistence.get_data(Main.current_user)
	
	if Main.current_user == null:
		$User.text = str("Usuario: Predeterminado")
	else:
		$User.text = str("Usuario: ", Main.current_user)
	
	$Money.text = str("Dinero: ", data["Money"])
	$Score.text = str("Puntaje: ", data["Score"])
	$YourPets.text = str("Mascotas: ", data["Pets"])

func _on_Back_pressed():
	get_tree().change_scene("res://Game/MainScreens/Awards.tscn")
