extends Node


var num_levels = 2
var current_level = 1

var title_screen = 'res://ui/HomeScreen.tscn'
var level1 = 'res://levels/Blue/BlueLevel01.tscn'


func restart():
	get_tree().change_scene(title_screen)

func next_level():
	get_tree().change_scene(level1)
