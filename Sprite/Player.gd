extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var inputInteracao = false;
var deslocamento_x = Vector2(4,0);
var deslocamento_y = Vector2(0,4);
var direcao = 0;
var pos_x = 0;
var pos_y = 0;
var matrixY =[104,184,264,344,424];
var matrixX =[176,272,364,460,552,648,740]
var dx;
var dy;
var mov_flag = 0;
var Com_objeto = -1;
var points = 0
var flag_acao = false;
signal posicao_player
var spawn_itens = [
	preload("res://Losangulo.tscn"),
	preload("res://Triangulo.tscn"),
	preload("res://Quadrado.tscn")]
onready var Matrix = get_node("/root/MainGame/Timer").TrashMatrix

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass
var sprite = ["Stop", "Front-walk", "Back-walk","Stop item", "Front-walk item", "Back-walk item"]


func _physics_process(delta):
	#$Sprites.play(sprite[0])
	var inputL = false;
	var inputR = false;
	var inputU = false;
	var inputD = false;
	var inputPause = false;

	var is_pressed = false;
	
	inputL = Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A);
	inputR = Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D);
	inputU = Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W);
	inputD = Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S);
	inputInteracao = Input.is_key_pressed(KEY_Q) or Input.is_key_pressed(KEY_SPACE);
	
	direcao = 0;
	if inputU:
		direcao = 1;
	if inputD:
		direcao = 2;
	if inputL:
		direcao = 3;
	if inputR:
		direcao = 4;
	flag_acao = false;	
	if inputInteracao :
		_joga_obj();
		direcao = 0;
		
	if(direcao > 1 ):
		if Com_objeto == -1 :
			$Sprites.play(sprite[1])
		else :
			$Sprites.play(sprite[4])
			match Com_objeto :
				0 : 
					$banana.show();
					continue;
				1 : 
					$papel.show();
					continue;
				2 : 
					$lata.show();
					continue;		
			
			
	elif direcao == 1:
		if Com_objeto == -1 :
			$Sprites.play(sprite[2])
		else :
			$Sprites.play(sprite[5])
			match Com_objeto :
				0 : 
					$banana.show();
					continue;
				1 : 
					$papel.show();
					continue;
				2 : 
					$lata.show();
					continue
	else:
		if Com_objeto == -1 :
			$Sprites.play(sprite[0])
		else :
			$Sprites.play(sprite[3])
			match Com_objeto :
				0 : 
					$banana.show();
					continue;
				1 : 
					$papel.show();
					continue;
				2 : 
					$lata.show();
					continue;
	_atualiza_pos(direcao);
	

func _atualiza_pos(direcao):
	
	var pisox = 100000;
	var pisoy = 100000;
	var i = 0;
	var dif;
	
	if direcao != 0:
		if direcao == 1 or direcao == 2:
			dy = direcao;
		if direcao == 3 or direcao == 4:
			dx = direcao;
		
	if position.y > 104 and direcao == 1 :
		if 	_verifica_posicao(direcao) :
			set_position(position - deslocamento_y);
	elif position.y < 424 and direcao == 2 :
		if 	_verifica_posicao(direcao) :
			set_position(position + deslocamento_y);
	elif position.x > 176 and direcao == 3 :
		if 	_verifica_posicao(direcao) :
			set_position(position - deslocamento_x);
	elif position.x < 740 and direcao == 4 :
		if 	_verifica_posicao(direcao) :
			set_position(position + deslocamento_x);	
	elif direcao == 0 :
		if flag_acao == false :
			_aproximacao_player()
	
	var flag = false;
	i = 0;
	pisox = 100000;
	pisoy = 100000;
	while i  < 5 and flag == false :
		if position.y == matrixY[i] :
			flag = true;
			pos_y = i;
		else :		
			#if Matrix[pos_x][i] == -1:
			dif = position.y - matrixY[i];
			if abs(dif) < abs(pisoy) :
				pisoy = dif;
				pos_y = i;
			i = i+1;
	flag = false;
	i = 0;
	while i < 7 and flag == false :
		if position.x == matrixX[i] :
			flag = true;
			pos_x = i;
		else :
			#if Matrix[i][pos_y] == -1:
			dif = position.x - matrixX[i]
			if abs(dif) < abs(pisox) :
				pisox = dif;
				pos_x = i;
			i = i+1;
	#print(pos_x,"aaaa",pos_y)
	emit_signal("posicao_player", Vector2(pos_x, pos_y))			
					
func _verifica_posicao(direcao) :
#Verifica se o jogador pode movimentar para o proximo bloco	
#Lixos : 0,1,2 	Lixeiras 3,4,5
	var Matrix = get_node("/root/MainGame/Timer").TrashMatrix
	
	match direcao:
		1 :
			if position.x == matrixX[pos_x] :
				if 	(pos_y > 0 and Matrix[pos_x][pos_y-1] != -1) and position.y == matrixY[pos_y]:
					if!(_interacao_player_obj(Matrix[pos_x][pos_y-1])):
						direcao = 0;
					else :
						Matrix[pos_x][pos_y-1] = -1;
			else :
				direcao = 0;
			continue;
		2 : 
			if position.x == matrixX[pos_x] :
				if 	pos_y <  4 and Matrix[pos_x][pos_y+1] != -1 and position.y == matrixY[pos_y]:
					if!(_interacao_player_obj(Matrix[pos_x][pos_y+1])) :
						direcao = 0;
					else :
						Matrix[pos_x][pos_y+1] = -1;
			else :
				direcao = 0;
			continue;
		3 :
			if position.y == matrixY[pos_y]:
				if 	(pos_x > 0 and Matrix[pos_x-1][pos_y] != -1) and position.x == matrixX[pos_x]:
					if!(_interacao_player_obj(Matrix[pos_x-1][pos_y])):
						direcao = 0;
					else :
						Matrix[pos_x-1][pos_y] = -1;
			else :
				direcao = 0;
			continue;
		4 : 
			if position.y == matrixY[pos_y]:
				if 	(pos_x < 6 and Matrix[pos_x+1][pos_y] != -1) and position.x == matrixX[pos_x]:
					if!(_interacao_player_obj(Matrix[pos_x+1][pos_y])):
						direcao = 0;
					else :
						Matrix[pos_x+1][pos_y] = -1;
			else:		
				direcao = 0;	
			continue;
	#print("direcao",direcao)
	if direcao == 0 :
		_aproximacao_player()
		return(false);
	return(true);
	
func _aproximacao_player() :

	var pisox = 100000;
	var pisoy = 100000;
	var i = 0;
	var dif;

	
	var flagChangeX = true;
	var flagChangeY = true;
	for i in range(5):
		if position.y != matrixY[i] :
			dif = position.y - matrixY[i];
			#if Matrix[pos_x][i] == -1:
			if abs(dif) < abs(pisoy) : 
				pisoy = dif;
				pos_y = i;
				if dy == 1 and dif < 0:
					pisoy = pisoy * -1;
				elif dy == 2 and dif > 0:
					pisoy = pisoy * -1
		else :
			flagChangeY = false;
	for i in range(7):
		if position.x != matrixX[i] :
			dif = position.x - matrixX[i]
			#if Matrix[i][pos_y] == -1:
			if abs(dif) < abs(pisox) :
				pisox = dif;
				pos_x = i;
				if dx == 3 and dif < 0:
					pisox = pisox * -1;
				elif dx == 4 and dif > 0:
					pisox = pisox * -1
		else :
			flagChangeX = false;		
		
	if flagChangeX == true or flagChangeY == true:
		if abs(pisoy) < 100000 and flagChangeY == true :
			if pisoy > 0:
				if abs(pisoy) < 4: 
					set_position(position - Vector2(0,abs(pisoy)));
				else :
					set_position(position - deslocamento_y);
			else :
				if abs(pisoy) < 4 :
					set_position(position + Vector2(0,abs(pisoy)));
				else :
					set_position(position + deslocamento_y);
		elif abs(pisox) < 100000 and flagChangeX == true :
			if pisox > 0:
				if abs(pisox) < 4 :
					set_position(position - Vector2(0,abs(pisox)));
				else :
					set_position(position - deslocamento_x);
			else :
				if abs(pisox) < 4 :
					set_position(position + Vector2(0,abs(pisox)));
				else :
					set_position(position + deslocamento_x);

func _interacao_player_obj(matrix) :
	
	#print(matrix,"aaa",Com_objeto);
	if matrix > -1 and matrix < 3 and Com_objeto == -1 :
		get_node("/root/MainGame/Pickup_song").play()
		Com_objeto = matrix;
		#print("Com_objeto",Com_objeto);
		return(true);
	elif matrix >= 3:
		match matrix:
			3 :
				if Com_objeto == 0 :
					Com_objeto = -1; 
					$banana.hide();
					if flag_acao == false :
						points += 10
						get_node("/root/MainGame/Garbage_Song").play()
				continue;
			4 :
				if Com_objeto == 1 :
					$papel.hide();
					Com_objeto = -1;
					if flag_acao == false :
						points += 10
						get_node("/root/MainGame/Garbage_Song").play()
				continue;
			5 :
				if Com_objeto == 2 :
					$lata.hide()
					Com_objeto = -1;
					if flag_acao == false :
						points += 10
						get_node("/root/MainGame/Garbage_Song").play()
				continue;
		
	return(false);		
			 	
func _joga_obj() :
	var Timer = get_node("/root/MainGame/Timer")
	if Com_objeto != -1 :
		match direcao :
			1 : 
				if pos_y > 0 and Timer.TrashMatrix[pos_x][pos_y-1] == -1  and position.y == matrixY[pos_y] and position.x == matrixX[pos_x]:
					Timer.TrashMatrix[pos_x][pos_y-1] = Com_objeto;
					var item = spawn_itens[Com_objeto].instance()
					item.set_position(Vector2((96*pos_x)+176,(80*(pos_y-1))+104))
					get_node("/root/MainGame").add_child(item)
					flag_acao = true;					
					_interacao_player_obj(Com_objeto+3)

			2 :
				if pos_y < 4 and Timer.TrashMatrix[pos_x][pos_y+1] == -1  and position.y == matrixY[pos_y] and position.x == matrixX[pos_x]:
					Timer.TrashMatrix[pos_x][pos_y+1] = Com_objeto;
					var item = spawn_itens[Com_objeto].instance()
					item.set_position(Vector2((96*pos_x)+176,(80*(pos_y+1))+104))
					get_node("/root/MainGame").add_child(item)
					flag_acao = true;										
					_interacao_player_obj(Com_objeto+3)

			3 : 
				if pos_x > 0 and Timer.TrashMatrix[pos_x-1][pos_y] == -1  and position.y == matrixY[pos_y] and position.x == matrixX[pos_x]:
					Timer.TrashMatrix[pos_x-1][pos_y] = Com_objeto;
					var item = spawn_itens[Com_objeto].instance()
					item.set_position(Vector2((96*(pos_x-1))+176,(80*pos_y)+104))
					get_node("/root/MainGame").add_child(item)
					flag_acao = true;										
					_interacao_player_obj(Com_objeto+3)

			4 : 
				if pos_x < 6 and Timer.TrashMatrix[pos_x+1][pos_y] == -1  and position.y == matrixY[pos_y] and position.x == matrixX[pos_x]:
					Timer.TrashMatrix[pos_x+1][pos_y] = Com_objeto;
					var item = spawn_itens[Com_objeto].instance()
					item.set_position(Vector2((96*(pos_x+1))+176,(80*pos_y)+104))
					get_node("/root/MainGame").add_child(item)	
					flag_acao = true;									
					_interacao_player_obj(Com_objeto+3)

#		if position.y > matrixY[pos_y] :
#			set_position(position - deslocamento_y);
#		else :
#			set_position(position + deslocamento_y);
#	elif position.x != matrixX[pos_x] :
#		if position.x > matrixX[pos_x] :
#			set_position(position - deslocamento_x);
#		else :
#			set_position(position + deslocamento_x);
			##104
	## 176	##74x90	##828
			##496
