extends Node


var num_levels = 2
var current_level = 1

var title_screen = 'res://ui/HomeScreen.tscn'
var levels_screen = 'res://ui/LevelsSwitchboard.tscn'
var level1 = 'res://levels/Green/levels/GreenLevel01.tscn'

var levels = [
	'res://levels/Green/levels/GreenLevel01.tscn',
	'res://levels/Red/levels/RedLevel01.tscn'
]

func restart():
	get_tree().change_scene(title_screen)

func next_level():
	get_tree().change_scene(level1)

func open_level(i):
	if i > levels.size():
		return
	get_tree().change_scene(levels[i - 1])

func open_levels_screen():
	get_tree().change_scene(levels_screen)

func open_title_screen():
	get_tree().change_scene(title_screen)
