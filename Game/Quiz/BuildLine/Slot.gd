extends ColorRect

# empieza de 0 
var word

func _ready():
#	print(get_parent().get_parent().get_next_word()
	pass

#func get_drag_data(position):
#	pass
	
func can_drop_data(position, data):
	return true # Si puede recibir data
	
func drop_data(position, data):
	$Text.text = data
	# 50 175 56
	color = Color(0.50, 1.75, 0.56)