extends Area2D


signal pickup

var textures = {
	'blueCrystal': 'res://assets/PNG/Items/blueCrystal.png',
	'blueGem': 'res://assets/PNG/Items/blueGem.png',
	'blueJewel': 'res://assets/PNG/Items/blueJewel.png',
	'yellowCrystal': 'res://assets/PNG/Items/yellowCrystal.png',
	'yellowGem': 'res://assets/PNG/Items/yellowGem.png',
	'yellowJewel': 'res://assets/PNG/Items/yellowJewel.png',
	'redCrystal': 'res://assets/PNG/Items/redCrystal.png',
	'redGem': 'res://assets/PNG/Items/redGem.png',
	'redJewel': 'res://assets/PNG/Items/redJewel.png',
	'greenCrystal': 'res://assets/PNG/Items/greenCrystal.png',
	'greenGem': 'res://assets/PNG/Items/greenGem.png',
	'greenJewel': 'res://assets/PNG/Items/greenJewel.png'
}


# Called when the node enters the scene tree for the first time.
func init(type, pos):
	$Sprite.texture = load(textures[type])
	position = pos

func _ready():
	var collShape = RectangleShape2D.new()
	collShape.extents = Vector2($Sprite.texture.get_width()/2,
								$Sprite.texture.get_height()/2)
	$CollisionShape2D.shape = collShape

func _on_Collectible_body_entered(body):
	if body.is_in_group("player"):
		emit_signal('pickup')
		queue_free()
