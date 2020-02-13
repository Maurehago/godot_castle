extends Node

export var triggerId = ""
export var info = "öffne Türe"

var Main :Node

func _ready() -> void:
	Main = get_tree().get_root().get_node("Main")

func player_interact(player) -> String:
	return info

func do_action(player) -> void:
	if Main and Main.has_method("wechsle_szene"):
		Main.wechsle_szene(triggerId)
		
