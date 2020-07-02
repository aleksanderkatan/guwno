extends KinematicBody2D

#all the variables
const UP = Vector2(0, -1)
const VERTICAL_ACCELERATION = 100
const VERTICAL_MAX_SPEED = 500 #this is not a cap, simply you won't accelerate further than this
const FRICTION = 200
const GRAVITY = 40
const JUMP_SPEED = 500
const JUMP_MAX_LENGTH = 15

var motion = Vector2()
var should_adjust = true
var current_jump_length = 0

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE) or fallen():
		get_tree().reload_current_scene()
	#if is_on_wall():
		#if motion.y < 0:
		#	motion.y = -GRAVITY
		#if Input.is_key_pressed(KEY_U):
		#	motion.y -= VERTICAL_ACCELERATION
	if is_on_floor():
		if !Input.is_key_pressed(KEY_U):
			current_jump_length = 0

func _physics_process(delta):
	var should_adjust = true
	if Input.is_key_pressed(KEY_D):
		if not Input.is_key_pressed(KEY_A):
			move_right()
			should_adjust = false
	if Input.is_key_pressed(KEY_A):
		if not Input.is_key_pressed(KEY_D):
			move_left()
			should_adjust = false
	
	if Input.is_key_pressed(KEY_U):
		if current_jump_length < JUMP_MAX_LENGTH:
			current_jump_length = current_jump_length + 1
			motion.y = -JUMP_SPEED
	else:
		current_jump_length=JUMP_MAX_LENGTH
	
	if should_adjust:
		adjust_motion()

	if is_on_ceiling():
		motion.y = 0

	motion.y+=GRAVITY
	motion = move_and_slide(motion, UP)
	pass


func move_right():
	if motion.x + VERTICAL_ACCELERATION <= VERTICAL_MAX_SPEED :
		motion.x = motion.x + VERTICAL_ACCELERATION


func move_left():
	if motion.x - VERTICAL_ACCELERATION >= -VERTICAL_MAX_SPEED :
		motion.x = motion.x - VERTICAL_ACCELERATION

func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return "left"
		elif collision.normal.x < 0:
			return "right"
	return "none"

func adjust_motion():
	if motion.x < -FRICTION:
		motion.x += FRICTION
	elif motion.x > FRICTION:
		motion.x -= FRICTION
	else:
		motion.x = 0
		
func fallen():
	if self.get_position().y > 1000.0:
		return true
	return false
