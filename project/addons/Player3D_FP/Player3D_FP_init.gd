tool
extends Spatial

# Player Scene
var scnPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Eltern Node suchen - Player soll in der selben Hiirachie eingefügt werden
	var parentNode = get_parent()
	
	# Szene mit Player laden
	scnPlayer = preload("Player.tscn").instance()
	
	# Player Szene zu der ElternNode hinzufügen
	parentNode.add_child(scnPlayer)
	scnPlayer.set_owner(parentNode)

	# dieses Skript aus dem Nodebaum entfernen
	queue_free()
