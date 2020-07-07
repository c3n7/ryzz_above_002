extends CanvasLayer


signal goingleft
signal goingright
signal notgoingleft
signal notgoingright
signal goup
signal godown


func _on_LeftButton_pressed():
	emit_signal("goingleft")

func _on_LeftButton_released():
	emit_signal("notgoingleft")

func _on_RightButton_pressed():
	emit_signal("goingright")

func _on_RightButton_released():
	emit_signal("notgoingright")

func _on_TopButton_pressed():
	emit_signal("goup")

func _on_TopButton_released():
	pass # Replace with function body.

func _on_BottomButton_pressed():
	emit_signal("godown")

func _on_BottomButton_released():
	pass # Replace with function body.
