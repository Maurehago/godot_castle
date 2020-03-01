extends Node

#sceneTree
var sceneTree :SceneTree

# Einstellungen für die Hauptszene
var HauptSzenePath : String  = "res://szene/Burg1.tscn"
var HauptSzene : Node
var packedHauptSzene : PackedScene
var isHauptSzene : bool = false

# Spieler Position
var playerPos : Transform
var playerPath : String = "/root/Burg1/Burg/Player"

# Weitere Einstellungen
var NebenSzene : String
var SzeneReader : String = "res://preflab/SzeneReader/SzeneReader.tscn"
var my_pos : Vector3
var my_richtung : Vector3
var DummiFile =File.new();
var SzeneReaderAktiv : bool = true

var Main :Node

func _ready():
	set_process_input(false)
	
	# SzeneTree merken
	sceneTree = get_tree()

	# hier für den Zugriff auf das Main
	Main = sceneTree.get_root().get_node("Main")
	
	# Hauptszene merken
	# alt: HauptSzene = sceneTree.current_scene
	#neu: Merken der Main Hauptszene
	HauptSzene = Main
	isHauptSzene = true

func zu_hauptszene():
	# Aktuelle Nebenszene auslesen und entfernen
	var current : Node = sceneTree.current_scene
	# Fehler bei Ausstieg
	if !current:
		return
	print (current.get_path())
	sceneTree.root.remove_child(current)
	current.queue_free()

	# alt:set_process_input(false)
	# neu: Maus verstecken
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Hauptszene neu setzen
	# alt: HauptSzene = packedHauptSzene.instance()
	sceneTree.root.add_child(HauptSzene)
	isHauptSzene = true
	
	# LOD's neu Prüfen
	Main.Player.LOD_init = true

	
	# Player Position neu
	# alt: get_node(playerPath).global_transform = playerPos

func zu_nebenszene(weg):
	# Nebenszene aufrufen
	NebenSzene = weg
	if DummiFile.file_exists(NebenSzene):
		# wenn Hauptszene
		if isHauptSzene:
			# Position merken
			# alt: playerPos = get_node(playerPath).global_transform
			
			# Hauptszene wegpacken
			# alt: packedHauptSzene = PackedScene.new()
			# alt:packedHauptSzene.pack(HauptSzene)
			sceneTree.root.remove_child(HauptSzene)
			# auf keinem Fall die Hauptszene löschen, da der Player da schon positioniert ist
			# alt: HauptSzene.queue_free()
			
		set_process_input(true)
		sceneTree.change_scene(NebenSzene)
		isHauptSzene = false

func _input(event):
	if event.is_action_pressed("ui_focus_next"):
		print(SzeneReaderAktiv)
		if SzeneReaderAktiv:
			SzeneReaderAktiv = false
			sceneTree.change_scene(SzeneReader)
		else:
			SzeneReaderAktiv = true
			sceneTree.change_scene(NebenSzene)
	
	# wenn Abbruch
	if event.is_action_pressed("ui_end"):
		# zur Hauptszene wechseln
		zu_hauptszene()
