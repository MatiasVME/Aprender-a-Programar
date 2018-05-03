extends ColorRect

func _ready():
	pass

func get_drag_data(position):
	var data = ColorRect.new()
	data.color = color
	data.rect_size = Vector2(250, 80) 
	set_drag_preview(data)
	
	return $Text.text # ???
	
#func can_drop_data(position, data):
#	return false
#
#func drop_data(position, data):
#	print("drop")