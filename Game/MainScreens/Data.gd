extends Node

func _ready():
	if Main.current_user == null:
		$VBox/User.text = str("Usuario: Predeterminado")
	else:
		$VBox/User.text = str("Usuario: ", Main.current_user)
	
	$VBox/Money.text = str("Dinero: ", Main.data["Money"])
	$VBox/Score.text = str("Puntaje: ", Main.data["Score"])
	$VBox/YourPets.text = str("Mascotas: ", Main.data["Pets"])
	
	$VBox/BubbleBoolFast.text = str("[Fast] = ", bubble_bool_mode_data(Main.data["MiniGames"]["BubbleBool"]["Fast"]))
	$VBox/BubbleBoolNormal.text = str("[Normal] = ", bubble_bool_mode_data(Main.data["MiniGames"]["BubbleBool"]["Normal"]))
	$VBox/BubbleBoolSlow.text = str("[Slow] = ", bubble_bool_mode_data(Main.data["MiniGames"]["BubbleBool"]["Slow"]))

	if not (Main.data["GoogleGames"] and Main.google_games != null):
		 $Leaderboard.hide()

func bubble_bool_mode_data(text_bubble_bool):
	text_bubble_bool = str(text_bubble_bool)
	text_bubble_bool = text_bubble_bool.replace("(", "")
	text_bubble_bool = text_bubble_bool.replace(")", "")
	
	return str(text_bubble_bool)

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	get_tree().change_scene("res://Game/MainScreens/Awards.tscn")

func _on_Leaderboard_pressed():
	if Main.google_games != null and Main.data["GoogleGames"]:
		Main.google_games.show_leaderboards()
