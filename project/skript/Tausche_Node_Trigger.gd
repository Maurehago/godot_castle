extends Node

export var triggerId = ""
export var info = "tausche Nodes"

var Main :Node

func _ready() -> void:
	Main = get_tree().get_root().get_node("Main")


func tausche_node() -> void:
	if Main and Main.has_method("tausche_node"):
		Main.tausche_node(triggerId)
		
