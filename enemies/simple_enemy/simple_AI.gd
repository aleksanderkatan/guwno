extends KinematicBody2D
class_name simple_enemy_body


const UP = Vector2(0, -1)
const GRAVITY = 40
const WALK_SPEED = 3000
const VIEW_RANGE = 500
const BULLET = preload("res://enemies/simple_enemy/simple_enemy_bullet.tscn")

var walk_time = 0
var direction = 1
var shot_delay = 0

func _ready():
	pass 



func _process(delta):
	var motion = Vector2()
	motion.x += WALK_SPEED * direction * delta
	walk_time += delta
	shot_delay += delta
	if walk_time > 5:
		walk_time = 0
		direction *= -1
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)
	#var player_position = get_node("/root/World/Player").position
	#if (player_position.x - self.position.x) + (player_position.y - self.position.y) < VIEW_RANGE and shot_delay > 2:
	#	print("created")
	#	var bullet = BULLET.instance()
	#	add_child(bullet)
	#	var bullet_direction = Vector2(player_position.x - self.position.x, player_position.y - self.position.y)
	#	shot_delay = 0
	pass
