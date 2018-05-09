extends RigidBody2D

var random_problem_generator = preload("res://Game/MiniGames/BubbleBoolean/RandProblemGenerator.gd")

signal correct
signal incorrect

func _ready():
	randomize()

func random_move():
	var rand_x = int(rand_range(-200, 200))
	var rand_y = int(rand_range(-200, 200))
	
	apply_impulse(Vector2(0,0),Vector2(rand_x, rand_y))

func _on_Movement_timeout():
	random_move()

func _on_Anim_animation_finished(anim_name):
	if anim_name == "show":
		random_move()
	if anim_name == "dead" or anim_name == "correct_dead" or anim_name == "incorrect_dead":
		queue_free()

func _on_Bubble1_correct():
	SoundManager.select_sound(SoundManager.CORRECT)
	SoundManager.play_sound()
	
	$Anim.play("correct_dead")

func _on_Bubble1_incorrect():
	SoundManager.select_sound(SoundManager.INCORRECT)
	SoundManager.play_sound()
	
	$Anim.play("incorrect_dead")

func _on_Button_button_down():
	if get_parent() == null:
		return
	
	if random_problem_generator.eval($Button/Text.text) == get_parent().boolean_state:
		emit_signal("correct")
	else:
		emit_signal("incorrect")
