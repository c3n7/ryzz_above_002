extends CanvasLayer


signal goingleft
signal goingright
signal notgoingleft
signal notgoingright
signal goup
signal godown



func _on_BottomButton_pressed():
	emit_signal("godown")


func _on_LeftButton_button_down():
	emit_signal("goingleft")


func _on_RightButton_button_down():
	emit_signal("goingright")


func _on_RightButton_button_up():
	emit_signal("notgoingright")


func _on_LeftButton_button_up():
	emit_signal("notgoingleft")


func _on_TopButton_pressed():
	emit_signal("goup")
