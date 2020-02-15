extends Spatial

# Enthält alle Szene- Namen und Pfade zum Laden
var Files = {
	"Burg": "res://Burg/Burg.tscn",
	"BibliothekVoll": "res://Burg/Bibliothek/Bibliothek.tscn",
	"BibliothekLeer": "res://preflab/burg/Bibliothek/Bibliothek.tscn"
}

# Bestimmt bei welcher TriggerId welche Szenen angezeigt werden sollen
# bei wechsle_szene -> ["neue_Szene", "neue_Spielerposition"]
# bei tausche_node 	-> ["Pfade_zu_Nodes,...", "neue_Szenen,..."]
var Game = {
	"start": ["Burg", "Pos1"],
	"showBibliothek": ["Bibliothek", "BibliothekVoll"],
	"hideBibliothek": ["Bibliothek", "BibliothekLeer"]
}

# Behälter für alle Geladenen Szene-Instanzen
var Scenes = {}

var World
var Player
var currentScene : Node
var currentSceneName : String
var currentPos : Node
var currentPosName : String

# Called when the node enters the scene tree for the first time.
func _ready():
	World = $World
	Player = $Player

	lade_szenen()
	start_szene()

func lade_szenen():
	# lade alle Szenen
	for n in Files:
		Scenes[n] = load(Files[n]).instance()

func start_szene():
	# Szenenwechsel mit start aufrufen
	wechsle_szene("start")
	
# Funktion zum wechseln der Szene
func wechsle_szene(triggerId):
	if currentScene:
		World.remove_child(currentScene)
	
	# neue Namen lesen
	if Game[triggerId]:
		currentSceneName = Game[triggerId][0]
		currentPosName = Game[triggerId][1]
	else:
		return
	
	# neue Objekte ermitteln
	if Scenes[currentSceneName]:
		currentScene = Scenes[currentSceneName]
		currentPos = currentScene.get_node(currentPosName)
	else:
		return
	
	# neue Szene hinzufügen
	World.add_child(currentScene)

	# Player Position setzen
	Player.global_transform = currentPos.global_transform

# Funktion um eine SzeneNode zu Tauschen
func tausche_node(triggerId):
	var oldNodePath : PoolStringArray
	var newSzeneName : PoolStringArray
	
	# neue Namen lesen
	if Game[triggerId]:
		oldNodePath = Game[triggerId][0].split(",")
		newSzeneName = Game[triggerId][1].split(",")
	else:
		return
	
	var size = oldNodePath.size()
	
	for i in range(size):
		# Node und Szene lesen
		var oldNode = currentScene.get_node(oldNodePath[i])
		var newSzene = Scenes[newSzeneName[i]]
		
		# Tauschen
		if oldNode and newSzene:
			currentScene.remove_child(oldNode)
			currentScene.add_child(newSzene)


