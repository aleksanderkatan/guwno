extends KinematicBody2D

#all the variables
const UP = Vector2(0, -1)
const VERTICAL_ACCELERATION = 20
const VERTICAL_MAX_SPEED = 200 #this is not a cap, simply you won't accelerate further than this
const FRICTION = 50
const GRAVITY = 15
const JUMP_SPEED = 500
const JUMP_BUFFER = 5
const WALL_JUMP_BUFFER = 5

var motion = Vector2()
var should_adjust = true
var jump_buffer = 0
var wall_jump_buffer = 0

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE) or fallen():
		get_tree().reload_current_scene()
	jump_buffer = jump_buffer - 1
	wall_jump_buffer = wall_jump_buffer - 1
	if is_on_wall():
		wall_jump_buffer = WALL_JUMP_BUFFER
	if is_on_floor():
		jump_buffer = JUMP_BUFFER

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

func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_U and not ev.echo:
		if is_on_floor() or jump_buffer > 0:
			if Input.is_key_pressed(KEY_U):
				motion.y = -JUMP_SPEED
		if is_on_wall() or wall_jump_buffer > 0:
			if Input.is_key_pressed(KEY_U):
				motion.y -= JUMP_SPEED/2
				if get_which_wall_collided() == "right":
					motion.x -= JUMP_SPEED
				else:
					motion.x += JUMP_SPEED

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
