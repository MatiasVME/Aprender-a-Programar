extends Node

func _ready():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(true)
		
	$Version.text = Main.version

func _on_Salir_pressed():
	get_tree().quit()
