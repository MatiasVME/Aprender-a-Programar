extends Node

onready var rand_problem_generator = load("res://Game/MiniGames/BubbleBoolean/RandProblemGenerator.gd").new()

func _ready():
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())
	
	print("es: ", rand_problem_generator.gen_rand_boolean_problem())



func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
	
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")
