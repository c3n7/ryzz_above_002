extends Area2D

signal entered

var textures = {
	'doorGreenTop': 'res://assets/PNG/Other/doorGreen_top.png',
	'doorGreenLock': 'res://assets/PNG/Other/doorGreen_lock.png',
	'doorGreenOpen': 'res://assets/PNG/Other/doorGreen.png',
	'doorRedTop': 'res://assets/PNG/Other/doorRed_top.png',
	'doorRedLock': 'res://assets/PNG/Other/doorRed_lock.png',
	'doorRedOpen': 'res://assets/PNG/Other/doorRed.png',
	'doorBrownTop': 'res://assets/PNG/Other/doorOpen_top.png',
	'doorBrownOpen': 'res://assets/PNG/Other/doorOpen.png'
}

#func _ready():
#	var collShape = RectangleShape2D.new()
#	collShape.extents = Vector2($Sprite.texture.get_width()/2,
#								$Sprite.texture.get_height()/2)
#	$CollisionShape2D.shape = collShape

# Called when the node enters the scene tree for the first time.
func init(type, pos):
	$Sprite.texture = load(textures[type])
	position = pos

func _on_Door_body_entered(body):
	if body.is_in_group("player"):
		emit_signal('entered')
