extends Node

export var triggerId = ""
export var info = "tausche Nodes"

var Main :Node

func _ready() -> void:
	Main = get_tree().get_root().get_node("Main")

# Trigger Funktion wird vom Player aus angestoßen
func trigger(Player:Node) -> void:
	if Main and Main.has_method("run_trigger"):
		Main.run_trigger(triggerId)
