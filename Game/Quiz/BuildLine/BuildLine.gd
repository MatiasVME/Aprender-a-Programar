extends Node

const TEST_MODE = true

var sort_line = []
var disorderer_line = []

var get_next_word_num = -1

func _ready():
	pass

func disorderer():
	disorderer_line = sort_line.duplicate()
	disorderer_line.shuffle()
	
#func get_next_word():
#	get_next_word_num += 1
#
#	if get_next_word_num < sort_line.size():
#		return sort_line[get_next_word_num]