extends Node

var NebenSzene : String
var HauptSzene : String  = "res://szene/Burg1.tscn"
var SzeneReader : String = "res://preflab/SzeneReader/SzeneReader.tscn"
var my_pos : Vector3
var my_richtung : Vector3
var zeit : int
var directory = Directory.new();

func zu_nebenszene(weg):
	if !weg.empty():
		NebenSzene = weg
	if directory.file_exists(NebenSzene) and OS.get_system_time_msecs() - zeit > 500:
		zeit = OS.get_system_time_msecs()
		get_tree().change_scene(NebenSzene)

func zu_hauptszene():
	if directory.file_exists(HauptSzene) and OS.get_system_time_msecs() - zeit > 500:
		zeit = OS.get_system_time_msecs()
		get_tree().change_scene(HauptSzene)

func zu_SzeneReader():
	if directory.file_exists(SzeneReader) and OS.get_system_time_msecs() - zeit > 500:
		zeit = OS.get_system_time_msecs()
		print("xxxx reader")
		get_tree().change_scene(SzeneReader)
		
func back_nebenszene():
	if directory.file_exists(NebenSzene) and OS.get_system_time_msecs() - zeit > 500:
		zeit = OS.get_system_time_msecs()
		get_tree().change_scene(NebenSzene)