extends Node


var all_quiz = []

func _ready():
	randomize()
	
	if Main.current_chapter == null:
		Main.current_chapter = 7

	$PracticeTemplate.configure_practice(all_quiz)

	all_quiz.shuffle()
	
	$PracticeTemplate.add_quiz_array(all_quiz)

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "start":
		$PracticeTemplate.next_quiz()
