extends MarginContainer


onready var life_counter = [
	$HBoxContainer/HBoxContainer/L1,
	$HBoxContainer/HBoxContainer/L2,
	$HBoxContainer/HBoxContainer/L3,
	$HBoxContainer/HBoxContainer/L4,
	$HBoxContainer/HBoxContainer/L5
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Player_life_changed(value):
	for life in range(life_counter.size()):
		life_counter[life].visible = value > life

func _on_score_changed(value):
	$HBoxContainer/ScoreLabel.text = str(value)

