extends Timer

var obj
var x
var y
var TrashMatrix = [
	[-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1]]
var level = 1
var trashcount = 0
var pos_player = Vector2()
var spawn_itens = [
	preload("res://Losangulo.tscn"),
	preload("res://Triangulo.tscn"),
	preload("res://Quadrado.tscn")]
enum Objetos {Banana = 0,Papel,Latinha,LixeiraMarrom,LixeiraAzul,LixeiraAmarelo}

func _ready():
	#quando o tempo acaba brota mais lixo
	connect("timeout",self, "_brota_lixo")
	pass
	
func _brota_lixo():
	var a = false
	var i = 0;
	while a != true:
		i = i + 1;
		print("i:",i,"teste");
		_gera_coordenada();
		#verifica se existe algo na matriz ou se o número gerado já existe
		if TrashMatrix[x][y] == -1:
			a = true
			TrashMatrix[x][y] = obj
			_instancia_lixo()
		if i == 50:
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			get_tree().change_scene("res://Game_over.tscn");
			a = true;

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
	if level == 2:
		wait_time = 2
	elif level >8:
		wait_time = 0.25
	else:
		wait_time -= 0.25
		
	#subir a dificuldade
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	
func _instancia_lixo():
	#converter coordenada gerada para a coordenada do jogo
	#instanciar o objeto
	var item = spawn_itens[obj].instance()
	item.set_position(Vector2((96*x)+176,(80*y)+104))
	get_node("/root/MainGame").add_child(item)
	
	
	
	
	

func _on_MainGame_lixeiras_pos(pos):
	for z in range(3):
		TrashMatrix[pos[z].x][pos[z].y] = 3+z
	pass # replace with function body


func _on_Player_posicao_player(new_pos_player):
	#print(new_pos_player.x,"aaaa",new_pos_player.y)
	TrashMatrix[pos_player.x][pos_player.y] = -1
	pos_player = new_pos_player
	TrashMatrix[pos_player.x][pos_player.y] = 7
	pass # replace with function body

func atualiza_matriz(new_pos):
	TrashMatrix[new_pos.x][new_pos.y] = -1

