extends Node2D

var pet

func _ready():
	var pet_name = Main.data["PetSelected"]
	
	# TODO: Usar el pet del usuario
	pet = load(str("res://Game/Pets/", pet_name, "/", pet_name, ".tscn")).instance()
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