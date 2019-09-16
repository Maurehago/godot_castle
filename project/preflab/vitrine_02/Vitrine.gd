extends Spatial

export var Szene_01 = ""
export var Szene_02 = ""
export var Szene_03 = ""
export var Bild = ""

func _ready():
	
	$vitrine/Sprite3D.texture = load(Bild)
	set_process(false)
	pass

func _process(delta):
	if Input.is_action_pressed("vitrine_1"):
		print(Szene_01)
		get_node("/root/AutoLoad").zu_nebenszene(Szene_01)
		set_process(false)
	if Input.is_action_pressed("vitrine_2"):
		get_node("/root/AutoLoad").zu_nebenszene(Szene_02)
		set_process(false)
	if Input.is_action_pressed("vitrine_3"):
		get_node("/root/AutoLoad").zu_nebenszene(Szene_03)
		set_process(false)
		

func _on_Area_body_entered(body):
	set_process(true)

func _on_Area_body_exited(body):
	set_process(false)
