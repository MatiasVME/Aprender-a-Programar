extends Node

var ot_is_get_reward = true
var data

func _ready():
	Main.reward_amount = 1
	
	data = Persistence.get_data()
	
	updated_x2()
	update_text()

func _on_X2_pressed():
	if Main.firebase != null:
		Main.firebase.show_rewarded_video()

func _on_Timer_timeout():
	updated_x2()
	
	if ot_is_get_reward and is_get_reward():
		ot_is_get_reward = false
		
#		win_score 
	
func updated_x2():
	if Main.firebase != null and Main.admob_video_is_loaded and Main.reward_amount == 1:
		$X2.show()
	else:
		$X2.hide()
	
	update_text()
	
func is_get_reward():
	if Main.reward_amount > 1:
		return true
	return false
	
func update_text():
	$WinScore.text = str("Puntaje Ganado: ", Main.win_score)
	$WinMoney.text = str("Dinero Ganado: ", Main.win_money)
	
	if not data.empty():
		# NOTE: El score no se añade en este momento, primero hay que saber
		# si el player le da al botón X2
		$TotalScore.text = str("Puntaje Total: ", data["Score"] + Main.win_score)
		$TotalMoney.text = str("Dinero Total: ", data["Money"] + Main.win_money)

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
	