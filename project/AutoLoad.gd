extends Node

var NebenSzene : String
var HauptSzene : String  = "res://szene/Burg1.tscn"
var SzeneReader : String = "res://preflab/SzeneReader/SzeneReader.tscn"
var my_pos : Vector3
var my_richtung : Vector3
var DummiFile =File.new();
var SzeneReaderAktiv : bool = true

func _ready():
	set_process_input(false)

func zu_nebenszene(weg):
	NebenSzene = weg
	if DummiFile.file_exists(NebenSzene):
		set_process_input(true)
		get_tree().change_scene(NebenSzene)

func _input(event):
	if event.is_action_pressed("ui_focus_next"):
		print(SzeneReaderAktiv)
		if SzeneReaderAktiv:
			SzeneReaderAktiv = false
			get_tree().change_scene(SzeneReader)
		else:
			SzeneReaderAktiv = true
			get_tree().change_scene(NebenSzene)
	if event.is_action_pressed("ui_end"):
		set_process_input(false)
		get_tree().change_scene(HauptSzene)