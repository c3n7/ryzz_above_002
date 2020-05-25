extends Area2D

signal inwater
signal notinwater

var textures = {
	'waterBlue1': 'res://assets/PNG/Other/fluidBlue_top.png',
	'waterBlue2': 'res://assets/PNG/Other/fluidBlue.png',
	'waterBrown1': 'res://assets/PNG/Other/fluidBrown_top.png',
	'waterBrown2': 'res://assets/PNG/Other/fluidBrown.png',
	'waterGreen1': 'res://assets/PNG/Other/fluidGreen_top.png',
	'waterGreen2': 'res://assets/PNG/Other/fluidGreen.png',
	'waterRed1': 'res://assets/PNG/Other/fluidRed_top.png',
	'waterRed2': 'res://assets/PNG/Other/fluidRed.png'
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

func _on_Water_body_entered(body):
	print("Checking hsdkf" + str(randi()))
	if body.is_in_group("player"):
		print("Water entered" + str(randi()))
		emit_signal('inwater')


func _on_Water_body_exited(body):
		if body.is_in_group("player"):
			print("holla")
			emit_signal('notinwater')
