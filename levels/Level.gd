extends Node2D

signal score_changed

export (PackedScene) var player
export (PackedScene) var Collectible
export (PackedScene) var Water
export (PackedScene) var Door

onready var pickups = $Collectibles
onready var water = $Water

var score

var collectibles = [
	'blueGem', 'blueJewel', 'blueCrystal',
	'redGem', 'redJewel', 'redCrystal',
	'greenGem', 'greenJewel', 'greenCrystal',
	'yellowGem', 'yellowJewel', 'yellowCrystal'
]

var waterTiles = [
	'waterBlue1', 'waterBlue2',
	'waterBrown1', 'waterBrown2',
	'waterGreen1', 'waterGreen2',
	'waterRed1', 'waterRed2'
]

var doorTiles = [
	'doorGreenTop', 'doorGreenLock', 'doorGreenOpen',
	'doorRedTop', 'doorRedLock', 'doorRedOpen',
	'doorBrownTop', 'doorBrownOpen'
]

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.set_responsiveness(GameState.Responsiveness.SHOW_MORE)
	score = 0
	emit_signal("score_changed", score)
	# Hide the markers, show the coins
	pickups.hide()
	spawn_pickups()
	
#	water.hide()
#	spawn_water()
	
	spawn_door()
	
	# Spawn the player
	var p = player.instance()
	p.spawn_pos = $PlayerSpawn.position
	p.connect('life_changed', $CanvasLayer/HUD,'_on_Player_life_changed')
	$Player.call_deferred("add_child", p)



func spawn_pickups():
	for cell in pickups.get_used_cells():
		var id = pickups.get_cellv(cell)
		var type = pickups.tile_set.tile_get_name(id)
		if type in collectibles:
			var c = Collectible.instance()
			var pos = pickups.map_to_world(cell)
			c.init(type, pos + pickups.cell_size / 2)
			call_deferred("add_child", c)
			c.connect('pickup', self, '_on_Collectible_pickup')

func spawn_water():
	for cell in water.get_used_cells():
		var id = water.get_cellv(cell)
		var type = water.tile_set.tile_get_name(id)
		if type in waterTiles:
			var w = Water.instance()
			var pos = water.map_to_world(cell)
			w.init(type, pos + water.cell_size /2)
			$WaterLayer.call_deferred("add_child", w)
			w.connect('inwater', self, '_on_InWater')
			w.connect('notinwater', self, '_on_NotInWater')

func spawn_door():
	for cell in pickups.get_used_cells():
		var id = pickups.get_cellv(cell)
		var type = pickups.tile_set.tile_get_name(id)
		if type in doorTiles:
			var d = Door.instance()
			var pos = pickups.map_to_world(cell)
			d.init(type, pos + pickups.cell_size)
			$Door.call_deferred("add_child", d)
			d.connect('entered', self, '_on_Door_entered')

func _on_Player_dead():
	pass

func _on_Collectible_pickup():
	score += 1
	$CollectibleSound.play()
	emit_signal('score_changed', score)

func _on_InWater():
	for p in $Player.get_children():
		print("on water")
#		p.setInWater(true)
		p.hurt()

func _on_NotInWater():
	for p in $Player.get_children():
#		p.setInWater(false)
		pass

func _on_Door_entered():
	$LevelUpSound.play()
	yield($LevelUpSound, "finished")
	GameState.open_levels_screen()

func _on_Controls_goup():
	for p in $Player.get_children():
		p.move_in_direction("jump")


func _on_Controls_goingleft():
	for p in $Player.get_children():
		p.move_in_direction("left")


func _on_Controls_notgoingleft():
	for p in $Player.get_children():
		p.cancel_move_in_direction("left")


func _on_Controls_goingright():
	for p in $Player.get_children():
		p.move_in_direction("right")


func _on_Controls_notgoingright():
	for p in $Player.get_children():
		p.cancel_move_in_direction("right")
