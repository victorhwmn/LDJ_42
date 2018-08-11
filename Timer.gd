extends Timer

var obj
var x
var y
var TrashMatrix = [[],[],[],[],[],[],[]]
var level = 1
var trashcount = 0
var spawn_itens = [
	preload("res://Losangulo.tscn"),
	preload("res://Triangulo.tscn"),
	preload("res://Quadrado.tscn")]

func _ready():
	#quando o tempo acaba brota mais lixo
	connect("timeout",self, "_brota_lixo")
	pass
	
func _brota_lixo():
	var a = false
	while a != true:
		_gera_coordenada()
		#verifica se existe algo na matriz ou se o número gerado já existe
		if TrashMatrix[x].empty() == true or TrashMatrix[x].find(y, 0) == -1:
			a = true
			TrashMatrix[x].push_back(y)
			_instancia_lixo()
	trashcount += 1
	if trashcount % 20 == 0:
		trashcount = 0
		_level_up()
	
	
func _gera_coordenada():
	randomize()
	x = randi()%7
	randomize()
	y = randi()%5
	randomize()
	obj = randi()%3
	
func _level_up():
	level += 1
	#subir a dificuldade
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	
func _instancia_lixo():
	var item = spawn_itens[obj].instance()
	item.set_position(Vector2((96*x)+176,(80*y)+104))
	get_node("/root/MainGame").add_child(item)
	
	
	
	#converter coordenada gerada para a coordenada do jogo
	#instanciar o objeto
	