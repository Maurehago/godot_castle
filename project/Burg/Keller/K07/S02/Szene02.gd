extends Node2D

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	# Funktion wird bei jedem Frame aufgerufen
	############### Szene zurück setzen ############
	if Input.is_key_pressed(KEY_R):
		# Szene zurücksetzen
		get_tree().reload_current_scene()
	############### Szene in Pausemodus setzen #####
	if Input.is_key_pressed(KEY_P):
		# Mauszeiger sichtbar machen
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		# Dialogfenster öffnen
		# ! das Dialogfenster darf nicht in Pausemodus
		# deswegen AcceptDialog => Inspektor => Pause => Mode = Process
		# dialog mit show aufrufen und nicht mit popup 
		$AcceptDialog.show()
		# Szene pausieren
		get_tree().paused = true
	################# Anwendung beenden ############
	if Input.is_key_pressed(KEY_Q):
		# get_tree().quit()
		# würde die Anwendung beenden
		pass

func _on_AcceptDialog_confirmed():
	############### Pausemodus beenden  ###########
	# wenn der button gedrückt wird
	# Szene weiter abarbeiten
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false
