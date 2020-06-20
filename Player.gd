extends KinematicBody2D

#all the variables
const UP = Vector2(0, -1)
var vertical_acceleration = 20
var vertical_max_speed = 200 #this is not a cap, simply you won't accelerate further than this
var friction = 50
var gravity = 15
var jump_speed = 500

var motion = Vector2()

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().reload_current_scene()

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

	if is_on_floor():
		motion.y = 0
		if Input.is_key_pressed(KEY_U):
				motion.y = -jump_speed 
	
	if is_on_ceiling():
		motion.y = 0
		
	if is_on_wall():
		if Input.is_key_pressed(KEY_U):
			motion.y -= jump_speed/2
			if get_which_wall_collided() == "right":
				motion.x -= jump_speed
			else:
				motion.x += jump_speed



	motion.y+=gravity
	move_and_slide(motion, UP)
	pass


func move_right():
	if motion.x + vertical_acceleration <= vertical_max_speed :
		motion.x = motion.x + vertical_acceleration


func move_left():
	if motion.x - vertical_acceleration >= -vertical_max_speed :
		motion.x = motion.x - vertical_acceleration

func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return "left"
		elif collision.normal.x < 0:
			return "right"
	return "none"

func adjust_motion():
	if motion.x < -friction:
		motion.x += friction
	elif motion.x > friction:
		motion.x -= friction
	else:
		motion.x = 0
		
