extends Control


func _ready():
	GameState.set_responsiveness(GameState.Responsiveness.EXPAND)


func _on_Quit_pressed():
	$Click.play()
	yield($Click, "finished")
	get_tree().quit()


func _on_NewGame_pressed():
	$Click.play()
	yield($Click, "finished")
#	GameState.next_level()
	GameState.open_level(3)


func _on_Levels_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_levels_screen()
