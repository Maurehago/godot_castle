extends Node2D

func _ready():
	pass 

func _process(delta):
	# Funktion wird bei jedem Frame aufgerufen
	############### Szene zurück setzen ############
	if Input.is_key_pressed(KEY_B):
		# Szene zurücksetzen
	############### Szene in Pausemodus setzen #####
		get_tree().reload_current_scene()
	if Input.is_key_pressed(KEY_P):
		# Panel sichtbar machen
		# ! das Panel darf nicht in Pausemoudus
		# deswegen Panel => Inspektor => Pause => Mode = Process
		$Panel.show()
		# Szene pausieren
		get_tree().paused = true
	################# Anwendung beenden ############
	if Input.is_key_pressed(KEY_Q):
		# get_tree().quit()
		# würde die Anwendung beenden
		pass
	################ Aufruf des SzeneReader ########
	################################################
	if Input.is_action_pressed("SzeneReader"):
		get_node("/root/AutoLoad").zu_SzeneReader()
	if Input.is_action_pressed("Hauptlevel"):
		get_node("/root/AutoLoad").zu_hauptszene()
	###############################################
	###############################################
		
func _on_Button_pressed():
	############### Pausemodus beenden  ###########
	# wenn der button gedrückt wird
	# Szene weiter abarbeiten
	get_tree().paused = false
	$Panel.hide()
