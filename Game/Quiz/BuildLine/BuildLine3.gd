extends Node

const TEST_MODE = true

var sort_line = []
var disorderer_line = []

func _ready():
	if TEST_MODE:
		sort_line.append("Uno")
		sort_line.append("Dos")
		sort_line.append("Tres")
		
		randomize()
		disorderer_line = sort_line.duplicate()
		disorderer_line.shuffle()
		
		for i in range(1, sort_line.size() + 1):
			# Añade las palabras correctas a los slots
			get_node(str("Slot", i)).word = sort_line[i - 1]
			# Añade las palabras desordenadas a los items
			get_node(str("Item", i, "/Text")).text = disorderer_line[i - 1]
			
func add_sort_line(word1, word2, word3):
	sort_line.append(word1)
	sort_line.append(word2)
	sort_line.append(word3)
	
func disorder():
	randomize()
	disorderer_line = sort_line.duplicate()
	disorderer_line.shuffle()
	
func set_up_slots_and_items():
	for i in range(1, sort_line.size() + 1):
		# Añade las palabras correctas a los slots
		get_node(str("Slot", i)).word = sort_line[i - 1]
		# Añade las palabras desordenadas a los items
		get_node(str("Item", i, "/Text")).text = disorderer_line[i - 1]

func is_correct():
	for i in range(1, sort_line.size() + 1):
		var slot = get_node(str("Slot", i))
		
		if slot.word != slot.get_node("Text").text:
			return false
			
	return true

func _on_Finish_pressed():
	if is_correct():
		print("win")
	else:
		print("lost")
