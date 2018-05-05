extends Node

func _ready():
	if Main.firebase != null:
		Main.firebase.show_banner_ad(false)