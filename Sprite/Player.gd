extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var deslocamento_x = Vector2(5,0);
var deslocamento_y = Vector2(0,5);
var direcao = 0;
var flag = false;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	var inputL = false;
	var inputR = false;
	var inputU = false;
	var inputD = false;
	var is_pressed = false;
	
	inputL = event.is_action_pressed("ui_left");
	inputR = event.is_action_pressed("ui_right");
	inputU = event.is_action_pressed("ui_up");
	inputD = event.is_action_pressed("ui_down");
	is_pressed = event.is_pressed();
	
	
	if is_pressed == false :
		direcao = 0;
	if inputU :
		direcao = direcao +1;
	if inputD :
		direcao = direcao + 2;
	if inputL :
		direcao = direcao + 4;
	if inputR :
		direcao = direcao + 8;

func _physics_process(delta):
	
	
	_atualiza_pos(direcao);

func _atualiza_pos(direcao):
	
	if(direcao == 1) :
		set_position(position - deslocamento_y);
	elif direcao == 2 :
		set_position(position + deslocamento_y);
	elif direcao == 4 :
		set_position(position - deslocamento_x);
	elif direcao == 5 :
		set_position(position - deslocamento_x - deslocamento_y);
	elif direcao == 6:
		set_position(position - deslocamento_x + deslocamento_y);
	elif direcao == 8 :
		set_position(position + deslocamento_x);
	elif direcao == 9 :
		set_position(position + deslocamento_x - deslocamento_y);
	elif direcao == 10:
		set_position(position + deslocamento_x + deslocamento_y);
	
	
	

