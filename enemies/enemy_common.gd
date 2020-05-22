extends Node

func enemyBodyEntered(body):
	if body.is_in_group("player"):
			body.hurt()
