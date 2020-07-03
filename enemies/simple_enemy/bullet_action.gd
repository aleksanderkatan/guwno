extends CollisionShape2D
class_name simple_enemy_bullet

const SPEED = 1000

var direction = Vector2()



func _ready():
	pass 


func _process(delta):
	self.position += direction * SPEED * delta 
	
	pass
	
func set_direction(given_direction):
	direction = given_direction
	
func _on_VisibilityNotifier2D_screen_exited():
	print("deleted")
	queue_free()
