extends Node2D

var pet

func _ready():
	# TODO: Usar el pet del usuario
	pet = load("res://Game/Pets/Stuar/Stuar.tscn").instance()
	add_child(pet)

func idle():
	if pet != null: 
		pet.get_node("Anim").play("idle")
		
func walk():
	if pet != null: 
		pet.get_node("Anim").play("walk")

func talk():
	if pet != null: 
		pet.get_node("Anim").play("talk")