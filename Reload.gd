extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("pressed", self, "onPressed");
	pass
	
func _input(event):	
	if(event.is_action_pressed("ui_cancel")):
		onPressed()


func onPressed() :
	get_tree().change_scene("res://MainGame.tscn")
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
