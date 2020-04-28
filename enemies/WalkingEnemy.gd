extends KinematicBody2D

export (int) var speed
export (int) var gravity

var velocity = Vector2()
var facing = 1

func _physics_process(delta):
	$AnimatedSprite.flip_h = velocity.x < 0
	velocity.y += gravity * delta
	velocity.x = facing * speed
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.is_in_group("player"):
			collision.collider.hurt()
		if collision.normal.x != 0:
			facing = sign(collision.normal.x)
		
		if position.y > 1000:
			queue_free()
