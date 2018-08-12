extends Node2D

var x
var y
signal lixeiras_pos
var lixeira = [
	preload("res://Lixeira-Amarela.tscn"),
	preload("res://Lixeira-Azul.tscn"),
	preload("res://Lixeira-Marrom.tscn")]
var pos = [Vector2(), Vector2(), Vector2()]

func _ready():
	var item
	var flag
	for z in range(3):
		item = lixeira[z].instance()
		_gera_coordenada()
		pos[z] = Vector2(x,y)
		while flag == true:
			for a in range(z+1):
				if pos[a] == pos[z] and a != z :
					flag = false
					_gera_coordenada()
					pos[z] = Vector2(x,y)
			if flag == false:
				flag = true
			else:
				flag = false
				
		item.set_position(Vector2((96*x)+176,(80*y)+104))
		self.add_child(item)
	
	emit_signal("lixeiras_pos",pos)
	
	pass

func _gera_coordenada():
	randomize()
	x = randi()%7
	randomize()
	y = randi()%5
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
