extends TextureButton


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	connect("pressed", self, "onPressed")
	# "pressed" is a signal
	# "self" is the button
	# "onPressed" is a function
	pass
func _input(event):
	if event.is_action("ui_accept"):
		onPressed();
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	pass

	
func onPressed() :
	get_tree().change_scene("res://MainGame.tscn")
	pass