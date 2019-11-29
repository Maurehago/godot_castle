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

func _ready():
	set_process_input(false)
	
	# SzeneTree merken
	sceneTree = get_tree()
	
	# Hauptszene merken
	HauptSzene = sceneTree.current_scene
	isHauptSzene = true

func zu_hauptszene():
	# Aktuelle Nebenszene auslesen und entfernen
	var current : Node = sceneTree.current_scene
	sceneTree.root.remove_child(current)
	current.queue_free()
	
	# Hauptszene neu setzen
	HauptSzene = packedHauptSzene.instance()
	sceneTree.root.add_child(HauptSzene)
	isHauptSzene = true
	set_process_input(false)
	
	# Player Position neu
	get_node(playerPath).global_transform = playerPos

func zu_nebenszene(weg):
	# Nebenszene aufrufen
	NebenSzene = weg
	if DummiFile.file_exists(NebenSzene):
		set_process_input(true)
		
		# wenn Hauptszene
		if isHauptSzene:
			# Position merken
			playerPos = get_node(playerPath).global_transform
			
			# Hauptszene wegpacken
			packedHauptSzene = PackedScene.new()
			packedHauptSzene.pack(HauptSzene)
			sceneTree.root.remove_child(HauptSzene)
			HauptSzene.queue_free()

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
