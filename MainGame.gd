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
		flag = true
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

func _process(delta):
	_game_over_check() 

func _gera_coordenada():
	x = 0;
	y = 0;
	while x == 0 and y == 0:
		randomize()
		x = randi()%7
		randomize()
		y = randi()%5
func _game_over_check() :
	
	var flag_canto_y = false;
	var flag_canto_x = false;
	var direcao_block = 0;
	var teto = 4;
	
	if $Player.pos_y > 0 :
		if $Timer.TrashMatrix[$Player.pos_x][$Player.pos_y-1] != -1 :
			direcao_block = direcao_block+1;
	else :
		flag_canto_y = true;
	if $Player.pos_y < 4 :
		if $Timer.TrashMatrix[$Player.pos_x][$Player.pos_y+1] != -1:
			direcao_block = direcao_block+1;
	else :
		flag_canto_y = true;
	if $Player.pos_x > 0:	
		if $Timer.TrashMatrix[$Player.pos_x-1][$Player.pos_y] != -1:
			direcao_block = direcao_block+1;
	else :
		flag_canto_x = true;
	if $Player.pos_x < 6 :
		if $Timer.TrashMatrix[$Player.pos_x+1][$Player.pos_y] != -1 :
			direcao_block = direcao_block +1;
	else :
		flag_canto_x = true;
		
	if flag_canto_x == true : 
		teto = teto - 1;
	if flag_canto_y == true :
		teto = teto - 1;
	#print("direcao =",direcao_block,"	teto = ",teto);
	if direcao_block >= teto :
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		if $Player.Com_objeto != -1 :
			get_tree().change_scene("res://Game_over.tscn")
			
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
