extends Node

func _ready():
	if Main.current_user == null:
		$User.text = str("Usuario: Predeterminado")
	else:
		$User.text = str("Usuario: ", Main.current_user)
	
	$Money.text = str("Dinero: ", Main.data["Money"])
	$Score.text = str("Puntaje: ", Main.data["Score"])
	$YourPets.text = str("Mascotas: ", Main.data["Pets"])
	
	var text_bubble_bool = Main.data["MiniGames"]["BubbleBool"]["Fast"]
	text_bubble_bool = str(text_bubble_bool)
	text_bubble_bool = text_bubble_bool.replace("(", "")
	text_bubble_bool = text_bubble_bool.replace(")", "")
	
	$BubbleBool.text = str("BubbleBool: ", str(text_bubble_bool))

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Awards.tscn")
