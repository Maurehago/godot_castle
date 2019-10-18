extends Spatial

export var Szene_1 = ""
export var Szene_2 = ""
export var Szene_3 = ""
export var Bild = ""
export var Skalierungsfaktor:float = 1
var dummi_file = File.new()

func _ready():
	set_process(false)
	if dummi_file.file_exists(Bild):
		$vitrine/Sprite3D.scale.x = Skalierungsfaktor
		$vitrine/Sprite3D.scale.y = Skalierungsfaktor
		$vitrine/Sprite3D.texture = load(Bild)

func _process(delta):
	if Input.is_action_pressed("ui_nr_1"):
		get_node("/root/AutoLoad").zu_nebenszene(Szene_1)
	if Input.is_action_pressed("ui_nr_2"):
		get_node("/root/AutoLoad").zu_nebenszene(Szene_2)
	if Input.is_action_pressed("ui_nr_3"):
		get_node("/root/AutoLoad").zu_nebenszene(Szene_3)

func _on_Area_body_entered(body):
	set_process(true)

func _on_Area_body_exited(body):
	set_process(false)
