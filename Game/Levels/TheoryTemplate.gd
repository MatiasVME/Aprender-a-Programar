extends Node

var ot_next_pressed = true

func _ready():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(false)
		
	Main.reset_values()
	
	if Main.current_chapter == null:
		Main.current_chapter = 1
	
	var cap = str("Cap", Main.current_chapter)
	# Solución rapida, ya el primer parrafo no se cuenta como ganancia.
	Main.win_money += Main.data["Chapters"][cap]["MoneyValueForDialogue"]
	Main.win_score += Main.data["Chapters"][cap]["ScoreValueForDialogue"]

func start_dialog(pet_name, rpg_dialog):
	var file = File.new()
	file.open("res://Game/Content.json", file.READ)
	var content = parse_json(file.get_as_text())
	file.close()
	
	for i in content["Pseudocode"]["Chapters"][str(Main.current_chapter)]["Theory"]:
		var current_dialog = content["Pseudocode"]["Chapters"][str(Main.current_chapter)]["Theory"][i]
		rpg_dialog.add_section(pet_name, current_dialog)
	
	rpg_dialog.start_dialog()

func _on_RPGDialog_changed_transmitter_name():
	$Top/Name.text = $RPGDialog.get_transmitter_name()

func _on_RPGDialog_updated_text():
	$Bottom/Text.text = $RPGDialog.get_text()

func _on_RPGDialog_start_dialog():
	$Anim.play("show")

func _on_RPGDialog_end_dialog():
	$Anim.play("finish")

func _on_Back_pressed():
	MusicManager.select_music(MusicManager.MENU)
	MusicManager.play_music()
	
	get_tree().change_scene("res://Game/Levels/Pseudocode/History.tscn")

func _on_Next_pressed():
	if ot_next_pressed:
		ot_next_pressed = false
		
		$RPGDialog.next_pressed()
		$Bottom/Next.hide()

func _on_ButtonDelay_timeout():
	ot_next_pressed = true
	$Bottom/Next.show()

func _on_RPGDialog_changed_text():
	var cap = str("Cap", Main.current_chapter)
	# Va sumando el score y dinero ganado por leer los dialogos
	Main.win_money += Main.data["Chapters"][cap]["MoneyValueForDialogue"]
	Main.win_score += Main.data["Chapters"][cap]["ScoreValueForDialogue"]

func _on_Anim_animation_finished(anim_name):
	if anim_name == "finish":
		if Main.firebase != null and Main.current_chapter != 1:
			Main.firebase.show_interstitial_ad()
