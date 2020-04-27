extends KinematicBody2D

export (int) var horizontal_velocity
export (int) var upward_velocity
export (int) var gravity_constant

enum {IDLE, RUN, JUMP, HURT, DEAD}

var state
var anim
var new_anim
var velocity = Vector2()
var run_speed = 0


func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			new_anim = 'idle'
		RUN:
			new_anim = 'run'
		HURT:
			new_anim = 'hurt'
		JUMP:
			new_anim = 'jump'
		DEAD:
			hide()

func get_input():
	if state == HURT:
		return # don't allow movement during hurt state

	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")

	# horizontal movement in all states
	velocity.x = 0
#	print(horizontal_velocity)
	if state == JUMP and !is_on_floor() and !velocity.y > 0:
		run_speed = horizontal_velocity + 100
	else:
		run_speed = horizontal_velocity

	if right:
		velocity.x += run_speed
		$AnimatedSprite.flip_h = false
	if left:
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = true

	# Only allow jumping when on the ground
	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y = upward_velocity
	# IDLE transitions to RUN when moving
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	# RUN transitions to IDLE when standing still
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	# Transition to JUMP when falling off an edge
	if state in [IDLE, RUN] and !is_on_floor():
		print("Falling")
		change_state(JUMP)


func _physics_process(delta):

	velocity.y += gravity_constant * delta
	get_input()

	if new_anim != anim:
		anim = new_anim
		$AnimatedSprite.play(anim)

	# Move the player
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if state == JUMP and is_on_floor():
		change_state(IDLE)
	if state == JUMP and velocity.y > 0:
		new_anim = 'fall'
