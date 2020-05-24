extends Control

func _on_BackButton_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_title_screen()

func _on_Level1_Button_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_level(1)


func _on_Level2_Button_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_level(2)
