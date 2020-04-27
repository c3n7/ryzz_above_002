extends Node2D

export (PackedScene) var player


# Called when the node enters the scene tree for the first time.
func _ready():
	var p = player.instance()
	p.spawn_pos = $PlayerSpawn.position
	p.connect('life_changed', $CanvasLayer/HUD,'_on_Player_life_changed')
	$Player.call_deferred("add_child", p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
