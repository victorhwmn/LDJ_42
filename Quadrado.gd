extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var matrixY =[104,184,264,344,424];
var matrixX =[176,272,368,464,560,656,752]
onready var timer = get_node("/root/MainGame/Timer")

signal atualiza_matriz

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var x
	var y
	var pos = get_position()
	#print (pos)
	var obj = get_colliding_bodies()
	#print(obj)
	if obj.empty() == false:
		#x = matrixX.find(pos.x)
		for i in range(7):
			if matrixX[i] == pos.x:
				x = i
				break
		#y = matrixY.find(pos.y)
		for i in range(5):
			if matrixY[i] == pos.y:
				y = i
				break
		#print(x," ",y)
		#print(pos.x," ",pos.y)
		timer.connect("atualiza_matriz", self, "atualiza_matriz")
		emit_signal("atualiza_matriz", Vector2(x,y))
		queue_free();
#	pass
