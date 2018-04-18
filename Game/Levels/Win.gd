extends Node

func _ready():
	updated_x2()

func _on_X2_pressed():
	if Main.firebase != null:
		Main.firebase.show_rewarded_video()

func _on_Timer_timeout():
	updated_x2()
	
func updated_x2():
	print("Main.firebase.request_rewarded_video_status():", Main.firebase.request_rewarded_video_status())
	print("Main.firebase: ", Main.firebase)
	
	if Main.firebase != null and Main.firebase.request_rewarded_video_status() != null:
		$X2.show()
		print("puede mostrarse")
	else:
		$X2.hide()
		print("nope")

func _on_Back_pressed():
	get_tree().change_scene("")
