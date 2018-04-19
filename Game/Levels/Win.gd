extends Node

var get_reward = false

func _ready():
	Main.reward_amount = 1
	updated_x2()
	update_text()

func _on_X2_pressed():
	if Main.firebase != null:
		Main.firebase.show_rewarded_video()

func _on_Timer_timeout():
	updated_x2()
	
func updated_x2():
	if Main.firebase != null and Main.admob_video_is_loaded and not get_reward:
		$X2.show()
	else:
		$X2.hide()

	update_text()

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")
	
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
	