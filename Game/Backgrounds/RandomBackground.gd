extends TextureRect

func _ready():
	randomize()
	var rand_num = int(round(rand_range(1, 9)))
	
	var new_texture = load(str("res://Game/Backgrounds/Background", rand_num, ".jpg"))
	texture = new_texture
