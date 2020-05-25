extends KinematicBody2D

signal life_changed
signal dead


export (int) var horizontal_velocity
export (int) var upward_velocity
export (int) var gravity_constant

enum {IDLE, RUN, JUMP, HURT, DEAD}

var state
var anim
var new_anim
var velocity = Vector2()
var run_speed = 0
var spawn_pos
var jumpnow = false
var goright = false
var goleft = false
var inwater = false
var waterhit = false
var dangerhit = false
var life

var max_jumps = 2
var jump_count = 0

func start():
	life = 3
	emit_signal('life_changed', life)
	position = spawn_pos
	show()
	change_state(IDLE)

func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			new_anim = 'idle'
		RUN:
			if inwater:
				new_anim = 'swim'
			else:
				new_anim = 'run'
		HURT:
			new_anim = 'hurt'
			velocity.y = -600
			life -= 1
			emit_signal('life_changed', life)
			yield(get_tree().create_timer(0.5), 'timeout')
			change_state(IDLE)
			if life <= 0:
				change_state(DEAD)
		JUMP:
			new_anim = 'jump'
			jump_count = 1
		DEAD:
			new_anim = "dead"
			yield(get_tree().create_timer(3), "timeout")
			emit_signal('dead')
			GameState.restart()

func move_in_direction(dir):
	match dir:
		"right":
			goright = true
		"left":
			goleft = true
		"jump":
			if is_on_floor():
				jumpnow = true
			elif state == JUMP and jump_count < max_jumps:
				jumpnow = true

func cancel_move_in_direction(dir):
	match dir:
		"right":
			goright = false
		"left":
			goleft = false

func hurt():
	waterhit = false
	dangerhit = false
	if state != HURT:
		change_state(HURT)

func setInWater(isInWater):
	if !isInWater and state == JUMP:
		inwater = isInWater
	else:
		inwater = true

func get_input():
	if state == DEAD:
		return # don't allow movement during dead state

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

	if right || goright:
		velocity.x += run_speed
		$AnimatedSprite.flip_h = false
	if left || goleft:
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = true

	# Only allow jumping when on the ground
	if jump || jumpnow:
		jumpnow = false 
		if is_on_floor():
			$Jump.play()
			change_state(JUMP)
			velocity.y = upward_velocity
		elif state == JUMP and jump_count < max_jumps:
			new_anim = 'jump_again'
			$Jump.play()
			velocity.y = upward_velocity / 1.5
			jump_count += 1
	
	# IDLE transitions to RUN when moving
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	# RUN transitions to IDLE when standing still
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	# Transition to JUMP when falling off an edge
	if state in [IDLE, RUN] and !is_on_floor():
		change_state(JUMP)


func _physics_process(delta):
	# Just in case the guy was in the air
	# if dead, x velocity should be zero
	if state == DEAD:
		velocity.x = 0
	
	velocity.y += gravity_constant * delta
		
	get_input()

	if new_anim != anim:
		anim = new_anim
		$AnimatedSprite.play(anim)

	# Move the player
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
#	if state == JUMP and is_on_floor() and !waterhit:
	if state == JUMP and is_on_floor():
		change_state(IDLE)
	if state == JUMP and velocity.y > 0:
		new_anim = 'fall'
	
	if state in [HURT, DEAD]:
		return;	
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.name in ['Danger', 'Water']:
			hurt()

	if position.y > 1000:
		change_state(DEAD)
