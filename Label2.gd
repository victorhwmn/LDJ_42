extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var points = get_node("/root/MainGame/Player").points
	Manage_scene.score = points
	#print(points)
	set_text(" " + str(points));
	pass
