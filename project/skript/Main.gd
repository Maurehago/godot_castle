extends Spatial

# Pfade
var Paths = {
	"Burg": "res://Burg/Burg.tscn",
	"BibliothekVoll": "res://Burg/Bibliothek/Bibliothek.tscn",
	"Bibliothek": "Burg/Bibliothek"
}

# Alle Zwischengespeicherten Nodes
var Nodes = {}

# Bestimmt bei welcher TriggerId was ausgeführt werden soll
#setNode,setPlayer,load,unload,save,add,remove,show,hide
var Game = {
	"start": [
		"load=res://Burg/Burg.tscn,Burg",
		"load=res://preflab/burg/Bibliothek/Bibliothek.tscn,BibliothekLeer",
		"load=res://Burg/Bibliothek/Bibliothek.tscn,BibliothekVoll",
		"add=Burg,World",
		"setPlayer=Burg/Pos1"
	],
	
	"showBibliothek": [
		"remove=BibliothekLeer,Burg",
		"add=BibliothekVoll,Burg"
	],
	"hideBibliothek": [
		"remove=BibliothekVoll,Burg",
		"show=BibliothekLeer,Burg"
	]
}

# Behälter für alle Geladenen Szene-Instanzen
var Scenes = {}

var World
var Player
var currentScene : Node
var currentSceneName : String
var currentPos : Node
var currentPosName : String
var lastTriggerId : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	World = $World
	Player = $Player

	# World unter Szenen merken
	Nodes["World"] = World

	# Start Trigger ausführen
	run_trigger("start")

# Merkt sich eine Node unter einem bestimmten Namen
func set_node(sourceName:String, targetName:String) -> void:
	var sourceNode : Node
	
	# Source Lesen
	if sourceName.find("/") >= 0:
		# ist Pfad
		sourceNode = World.get_node(sourceName)
	else:
		# ist bestehende Node
		if Nodes.has(sourceName):
			sourceNode = Nodes[sourceName]

	# Wenn Vorhanden
	if sourceNode:
		# Node merken
		Nodes[targetName] = sourceNode
	else:
		Nodes[targetName] = null

# Läd eine Szene und merkt sich diese als Node
func load_scene(sourcePath:String, targetName:String) -> void:
	var sourceNode : Node
	
	# Source Lesen
	if sourcePath.begins_with("res://"):
		# ist Pfad
		sourceNode = load(sourcePath).instance()
	else:
		# Kein Pfad
		return
	
	# Wenn Vorhanden
	if sourceNode:
		# Node merken
		Nodes[targetName] = sourceNode
	else:
		Nodes[targetName] = null

# Entfernt eine Node komplett aus dem Speicher
func unload_scene(sceneName:String) -> void:
	var sourceNode : Node
	
	# Source Lesen
	if sceneName.find("/") >= 0:
		# ist Pfad
		sourceNode = World.get_node(sceneName)
	else:
		# ist bestehende Node
		if Nodes.has(sceneName):
			sourceNode = Nodes[sceneName]
			Nodes[sceneName] = null
	
	# Freigeben
	if sourceNode:
		sourceNode.queue_free()

# Speichert eine Szene
func save_scene(sourceName:String, targetPath:String):
	# todo: muss noch ausgetüftelt werden
	pass

# type= "add" -> fügt eine Node der Szene hinzu
# type= "remove" -> entfernt eine Node
# type= "show" -> zeigt eine Node an
# type= "hide" -> blendet eine Node aus
func change(sourceName:String, targetName:String, type:String) -> void:
	var sourceNode : Node
	var targetNode : Node
	
	# Source Lesen
	if sourceName.find("/") >= 0:
		# ist Pfad
		sourceNode = World.get_node(sourceName)
	else:
		# ist bestehende Node
		if Nodes.has(sourceName):
			sourceNode = Nodes[sourceName]

	# Target Lesen
	if targetName.find("/") >= 0:
		# ist Pfad
		targetNode = get_node(targetName)
	else:
		# ist bestehende Node
		if Nodes.has(targetName):
			targetNode = Nodes[targetName]

	# Wenn keine TargetNode
	if !targetNode:
		targetNode = World

	# Wenn Nodes vorhanden
	if sourceNode and targetNode:
		#print("source: " + sourceNode.get_path())
		#print("target: " + targetNode.get_path())
		if type == "add":
			# Node hinzufügen
			if sourceNode.get_parent():
				sourceNode.get_parent().remove_child(sourceNode)
			targetNode.add_child(sourceNode)
		elif type == "remove":
			# Node entfernen
			if sourceNode.find_parent(targetNode.name):
				targetNode.remove_child(sourceNode)
		elif type == "show":
			# Node anzeigen
			if sourceNode.has_method("show"):
				sourceNode.show()
		elif type == "hide":
			# Node entfernen
			if sourceNode.has_method("hide"):
				sourceNode.hide()

# Setzt den 3D-Player auf eine neue Position
func player_to_position(positionName) -> void:
	var posNode : Node
	
	# Source Lesen
	if positionName.find("/") >= 0:
		# ist Pfad
		posNode = World.get_node(positionName)
	else:
		# ist bestehende Node
		if Nodes.has(positionName):
			posNode = Nodes[positionName]

	# wenn PositionsNode Vorhanden
	if posNode:
		# Player Position setzen
		Player.global_transform = posNode.global_transform

# Fürt den angegebenen Trigger, mit den Daten aus "Game", aus
func run_trigger(triggerId:String) -> void:
	if triggerId == lastTriggerId:
		return
	
	var triggerList = Game[triggerId]

	# Alle Trigger Befehle durchgehen
	for t in triggerList:
		var cmd: String
		var cmdList: Array
		var paramList: Array
		var param1: String
		var param2: String
		
		if !t is String:
			return
		
		cmdList = t.split("=")
		if !cmdList[1]:
			return
		
		cmd = cmdList[0].strip_edges()
		paramList = cmdList[1].split(",")

		if paramList.size() > 0:
			param1 = paramList[0].strip_edges()
		if paramList.size() > 1:
			param2 = paramList[1].strip_edges()
		
		# Je nach Befehl ausführen
		#setNode,setPlayer,load,unload,save,add,remove,show,hide
		if cmd == "setNode":
			set_node(param1, param2)
		elif cmd == "setPlayer":
			player_to_position(param1)
		elif cmd == "load":
			load_scene(param1, param2)
		elif cmd == "unload":
			unload_scene(param1)
		elif cmd == "save":
			save_scene(param1, param2)
		else:
			change(param1, param2, cmd)
