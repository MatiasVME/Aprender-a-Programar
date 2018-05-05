extends RigidBody2D

func _ready():
	randomize()
	random_move()

func random_move():
	var rand_x = int(rand_range(-200, 200))
	var rand_y = int(rand_range(-200, 200))
	
	apply_impulse(Vector2(0,0),Vector2(rand_x, rand_y))

func _on_Movement_timeout():
	random_move()
