extends Node

const CANT_BUBBLES = 5
const COMBO_TIME = 3

var time_to_end = 60
var big_problems = false
var rigid_mode = false

onready var rand_problem_generator = preload("res://Game/MiniGames/BubbleBoolean/RandProblemGenerator.gd").new()

signal lost_combo
signal win_combo

var combo_amount = 0
var ot_lost_combo = true
var boolean_state = true
var can_spawn_bubbles = true

# Cantidad de problemas resueltos a resolver para que se muestre un gran problema
var amount_for_big_problem = 5
# Numero de problemas resueltos actuales para el gran problema
var count_for_big_problem = 0  

func _ready():
	Main.reset_bb()
	generate_first_bubbles()
	
	$ComboBar/ComboTime.wait_time = COMBO_TIME / 100.0
	
	connect("lost_combo", self, "_on_lost_combo")
	connect("win_combo", self, "_on_win_combo")
	
	$Black/Time.text = str(time_to_end)
	
	MusicManager.select_music(MusicManager.THEORY)
	MusicManager.play_music()

func generate_first_bubbles():
	for i in range(0, CANT_BUBBLES):
		create_bubble_according_to_level()
	
func create_bubble():
	if not can_spawn_bubbles:
		return
	
	var bubble
	
	if big_problems:
		if count_for_big_problem >= amount_for_big_problem:
			bubble = load("res://Game/MiniGames/BubbleBoolean/Bubbles/Bubble2.tscn").instance()
			bubble.get_node("Button/Text").text = rand_problem_generator.gen_rand_boolean_problem(false)
			count_for_big_problem = 0
			
			bubble_things(bubble)
		else:
			bubble = load("res://Game/MiniGames/BubbleBoolean/Bubbles/Bubble1.tscn").instance()
			bubble.get_node("Button/Text").text = rand_problem_generator.gen_rand_boolean_problem()
			
			bubble_things(bubble)
	else:
		bubble = load("res://Game/MiniGames/BubbleBoolean/Bubbles/Bubble1.tscn").instance()
		bubble.get_node("Button/Text").text = rand_problem_generator.gen_rand_boolean_problem()
			
		bubble_things(bubble)
	
	count_for_big_problem += 1

func create_bubble_according_to_level():
	match Main.bb_mode:
		Main.BBFAST:
			create_bubble()
		Main.BBNORMAL:
			big_problems = true
			time_to_end = 120
			create_bubble()
		Main.BBSLOW:
			big_problems = true
			rigid_mode = true
			amount_for_big_problem = 2
			time_to_end = 180
			create_bubble()

func bubble_things(bubble):
	var rand_pos_x = int(round(rand_range(128, 768)))
	var rand_pos_y = int(round(rand_range(128, 640)))
	
	bubble.position = Vector2(rand_pos_x, rand_pos_y)
	bubble.connect("correct", self, "_on_correct", [bubble])
	bubble.connect("incorrect", self, "_on_incorrect", [bubble])
	
	bubble.add_to_group("Bubble1")
	
	if rigid_mode:
		bubble.mode = bubble.MODE_RIGID
	
	add_child(bubble)

func dead_bubble(bubble):
	bubble.disconnect("correct", self, "_on_correct")
	bubble.disconnect("incorrect", self, "_on_incorrect")

func update_score():
	$Black/Score.text = str(Main.win_score)

func update_combo_amount_text():
	$ComboAnim.play("show_combo_amount")
	$ComboBar/Combos.text = str("X", combo_amount)

func _on_Back_pressed():
	SoundManager.select_sound(SoundManager.BUTTON)
	SoundManager.play_sound()
	
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
	
	get_tree().change_scene("res://Game/MainScreens/Modes.tscn")

func _on_TrueOrFalse_toggled(button_pressed):
	if button_pressed:
		boolean_state = false
		$Black/TrueOrFalse/Text.text = "False"
	else:
		boolean_state = true
		$Black/TrueOrFalse/Text.text = "True"

func _on_correct(bubble):
	create_bubble_according_to_level()
	
	$ComboBar/ComboBar.value = 100
	
	Main.win_score += 1
	Main.win_money += 1
	update_score()
	
	dead_bubble(bubble)
	
func _on_incorrect(bubble):
	create_bubble_according_to_level()
	
	$ComboBar/ComboBar.value = 0
	
	Main.win_score -= 5
	Main.win_money -= 1
	update_score()

	dead_bubble(bubble)

func _on_win_combo():
	combo_amount += 1
	ot_lost_combo = true
	
	Main.win_money += combo_amount
	Main.win_score += combo_amount
	update_score()
	
	update_combo_amount_text()
	
	if combo_amount > Main.bb_max_combo:
		Main.bb_max_combo = combo_amount

func _on_lost_combo():
	combo_amount = 0
	$ComboAnim.play_backwards("show_combo_amount")

func _on_ComboTime_timeout():
	if $ComboBar/ComboBar.value == 100:
		emit_signal("win_combo")
		
	$ComboBar/ComboBar.value -= 1
	
	if $ComboBar/ComboBar.value <= 0 and ot_lost_combo:
		ot_lost_combo = false
		emit_signal("lost_combo")

func _on_TimeTicks_timeout():
	$Black/Time.text = str(time_to_end)
	
	time_to_end -= 1
	
	if time_to_end == 0:
		# Se termina el juego
		for i in get_tree().get_nodes_in_group("Bubble1"):
			i.get_node("Anim").play("incorrect_dead")
		
		can_spawn_bubbles = false
		
		$Anim.play("end_level")
	
func _on_Anim_animation_finished(anim_name):
	if anim_name == "end_level":
		get_tree().change_scene("res://Game/MiniGames/BubbleBoolean/BBWin.tscn")
