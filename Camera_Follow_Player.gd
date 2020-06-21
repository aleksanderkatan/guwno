extends Camera2D


var player_pos


func _ready():
	player_pos = get_node("../Player").get_position()
	self.position = player_pos
	pass


func _process(delta):
	if player_pos.y < 500.0:
		player_pos = get_node("../Player").get_position()
		self.position = player_pos
	pass
	
