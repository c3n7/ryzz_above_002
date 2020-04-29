extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_pressed():
	$Click.play()
	yield($Click, "finished")
	get_tree().quit()


func _on_NewGame_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.next_level()
