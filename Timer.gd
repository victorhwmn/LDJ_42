extends Timer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var x
var y
var TrashMatrix = [[],[],[],[],[]]
var level = 1
var trashcount = 0
func _ready():
	#quando o tempo acaba brota mais lixo
	connect("timeout",self, "_brota_lixo")
	pass
	
func _brota_lixo():
	var a = false
	while a != true:
		_gera_coordenada()
		#verifica se existe algo na matriz ou se o número gerado já existe
		print(x)
		print(y)
		if TrashMatrix[x].empty() == true or TrashMatrix[x].find(y, 0) == -1:
			a = true
			TrashMatrix[x].push_back(y)
			_instancia_lixo()
	
func _gera_coordenada():
	randomize()
	x = randi()%5
	y = randi()%7
	
func _level_up():
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
func _instancia_lixo():
	print(x, y)