extends Node

func _ready():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(false)
		
	Main.reset_values()

func _on_RPGDialog_changed_transmitter_name():
	$Top/Name.text = $RPGDialog.get_transmitter_name()

func _on_RPGDialog_updated_text():
	$Bottom/Text.text = $RPGDialog.get_text()

func _on_RPGDialog_start_dialog():
	$Anim.play("show")

func _on_RPGDialog_end_dialog():
	$Anim.play_backwards("show")

func _on_Back_pressed():
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Next_pressed():
	$RPGDialog.next_pressed()
