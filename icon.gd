extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	time = randf() # Replace with function body.
	



var time = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time < 0.5:
		show()
	else:
		hide()
		if time > 1:
			time -= 1
