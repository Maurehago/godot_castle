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
		$StaticBody/vitrine/Sprite3D
		$StaticBody/vitrine/Sprite3D.scale.x = Skalierungsfaktor
		$StaticBody/vitrine/Sprite3D.scale.y = Skalierungsfaktor
		$StaticBody/vitrine/Sprite3D.texture = load(Bild)