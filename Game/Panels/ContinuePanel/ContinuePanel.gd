extends Node2D

signal exit
signal ok

func _ready():
	connect("exit", self, "on_exit")
	connect("ok", self, "on_ok")

func _on_Exit_pressed():
	emit_signal("exit")

func _on_OK_pressed():
	emit_signal("ok")

func on_exit():
	$Anim.play("hide")
	
func on_ok():
	$Anim.play("hide")