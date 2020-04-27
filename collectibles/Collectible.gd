extends Area2D


signal pickup

var textures = {
	'blueGem': 'res://assets/PNG/Items/blueGem.png',
	'blueJewel': 'res://assets/PNG/Items/blueJewel.png'
}


# Called when the node enters the scene tree for the first time.
func init(type, pos):
	$Sprite.texture = load(textures[type])
	position = pos

func _ready():
	var collShape = RectangleShape2D.new()
	collShape.extents = Vector2(11, 11)
	$CollisionShape2D.shape = collShape

func _on_Collectible_body_entered(body):
	emit_signal('pickup')
	queue_free()
