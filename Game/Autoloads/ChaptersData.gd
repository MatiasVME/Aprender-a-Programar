extends Node

func _ready():
	pass

func create_data(chapter):
	match chapter:
		2: chapter_2()
		3: chapter_3()
		4: chapter_4()
		5: chapter_5()
		6: chapter_6()
		7: chapter_7()
		
	Persistence.save_data(Main.current_user)

func chapter_2():
	if not Main.data["Chapters"].has("Cap2"):
		Main.data["Chapters"]["Cap2"] = {
			ScoreValueForDialogue = 3,
			MoneyValueForDialogue = 3,
			ScoreValueForAnswer = 5,
			MoneyValueForAnswer = 5,
			TheoryCompleted = false, # debe estar en false
			PracticeCompleted = false
		}

func chapter_3():
	if not Main.data["Chapters"].has("Cap3"):
		Main.data["Chapters"]["Cap3"] = {
			ScoreValueForDialogue = 3,
			MoneyValueForDialogue = 3,
			ScoreValueForAnswer = 5,
			MoneyValueForAnswer = 5,
			TheoryCompleted = false, # debe estar en false
			PracticeCompleted = false
		}

func chapter_4():
	if not Main.data["Chapters"].has("Cap4"):
		Main.data["Chapters"]["Cap4"] = {
			ScoreValueForDialogue = 4,
			MoneyValueForDialogue = 4,
			ScoreValueForAnswer = 6,
			MoneyValueForAnswer = 6,
			TheoryCompleted = false, # debe estar en false
			PracticeCompleted = false
		}

func chapter_5():
	if not Main.data["Chapters"].has("Cap5"):
		Main.data["Chapters"]["Cap5"] = {
			ScoreValueForDialogue = 4,
			MoneyValueForDialogue = 4,
			ScoreValueForAnswer = 6,
			MoneyValueForAnswer = 6,
			TheoryCompleted = false, # debe estar en false
			PracticeCompleted = false
		}

func chapter_6():
	if not Main.data["Chapters"].has("Cap6"):
		Main.data["Chapters"]["Cap6"] = {
			ScoreValueForDialogue = 4,
			MoneyValueForDialogue = 4,
			ScoreValueForAnswer = 6,
			MoneyValueForAnswer = 6,
			TheoryCompleted = false, # debe estar en false
			PracticeCompleted = false
		}

func chapter_7():
	if not Main.data["Chapters"].has("Cap7"):
		Main.data["Chapters"]["Cap7"] = {
			ScoreValueForDialogue = 5,
			MoneyValueForDialogue = 5,
			ScoreValueForAnswer = 7,
			MoneyValueForAnswer = 7,
			TheoryCompleted = false, # debe estar en false
			PracticeCompleted = false
		}
	