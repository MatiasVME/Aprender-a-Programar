extends Node

onready var incorrect = $Incorrect
onready var correct = $Correct
onready var button = $ButtonSound

enum Sound {
	INCORRECT,
	CORRECT,
	BUTTON
}

var current_sound = null

func select_sound(sound):
	if not Main.sound_enable:
		return
	
	match sound:
		Sound.INCORRECT:
			current_sound = incorrect
		Sound.CORRECT:
			current_sound = correct
		Sound.BUTTON:
			current_sound = button
		
func play_sound():
	if not Main.sound_enable:
		return
	
	if current_sound != null:
		current_sound.play()
		
func stop_sound():
	if current_sound != null:
		current_sound.stop()