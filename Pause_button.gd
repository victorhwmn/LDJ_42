extends Button

onready var texto = get_node("/root/MainGame/Control/Pause");

func _ready():
	texto.set_visible(0);
	connect("pressed", self, "_on_pause_pressed");
	pass

func _input(event):
	print("oi")
	if(event.is_action_pressed("ui_cancel")):
		_on_pause_pressed();
	pass

func _on_pause_pressed():
	
	print(texto)
	texto.set_visible(!texto.is_visible());
	if texto.is_visible():
		get_node("/root/MainGame/Control").set_as_toplevel(true)
	get_tree().paused = !(get_tree().paused)
	pass
