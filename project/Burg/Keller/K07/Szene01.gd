extends Node2D
# -Tastatur
# -Aktionen
	# über das Menü(Projekt) => Menüpunkt(Projekteistellung) => Dialogfenster => Reiter(EingabeZuordnung)
	# alternativ können wir auch per Skript Aktionen erstellen
# -Maus
# -Joystick

var aktionen = {"aktion_T" : KEY_T}
var i_e_k = InputEventKey.new()
var maus_rad : int = 0
var stick = [0,0,0,0]

func _ready():
	set_process(true)
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# liste der aktionen um dummi_aktion erweitern
	InputMap.add_action("dummi_aktion")
	i_e_k.scancode = aktionen["aktion_T"]	#  = KEY_T = 84
	InputMap.action_add_event("dummi_aktion", i_e_k) 

func _input(event):
	# diese Funktion wird bei einem Ereignis VOR der GUI aufgerufen
	# wollen wir das Ereignis NACH der GUI auswerten müssen wir die func _unhandled_input(event): verwenden
	############################ Taste #################################
	if event is InputEventKey:
		var dummi_text : String = ""
		# wenn eine Taste den Event auslöst
		# !!! Dies geschieht nur ein mal pro drücken einer Taste
		if event.pressed and event.scancode == KEY_A:
			# wenn eine Taste gedrückt und scancode gleich
			# get_tree().set_input_as_handled()
			# hiermit gilt das Ereignis als behandelt _unhandled_input erhält somit kein event
			dummi_text = "event Taste A"
			if event.shift:
				# Tastenkombinationen mit shift, alt, control
				dummi_text += " shift "
			if event.alt:
				dummi_text += " alt "
			if event.control:
				dummi_text += " control "
			$Label1.text = dummi_text
		elif event.pressed and event.scancode == KEY_W:
			$Label1.text = "event Taste W"
		else:
			# Taste wurde losgelassen oder ScanCode ist nicht gleich
			$Label1.text = ""
	############################## Aktion ###############################
	if event.is_action_pressed("dummi_aktion"):
		# wenn die Aktion "dummi_aktion" ausgelöst wurde
		$Label2.text = "Aktion Taste T"
	############################### Maustasten ##############################
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			$Label3.text = "event Maustaste Links"
		elif event.pressed and event.button_index == BUTTON_RIGHT:
			$Label3.text = "event Maustaste Rechts"
		else:
			$Label3.text = ""
		############################### MausRad ###############################
		# Das Scrollrad der Maus zählt auch zu den Buttonsignalen
		if  event.button_index == BUTTON_WHEEL_UP:
			maus_rad += 1
			$Label4.text = "event MausRad " + str(maus_rad)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			maus_rad -= 1
			$Label4.text = "event MausRad " + str(maus_rad)
		# die Auswertung von event.pressed ist hier nicht Zielführend
		# da immer zunächst True und danch False gesendet wird
	############################### Mausbewegung ##############################
	if event is InputEventMouseMotion:
		$Label5.text = str(event.position)
		$Label6.text = str(event.global_position)
		$Label7.text = str(event.speed)
		# wenn speed == 0 wird kein event ausgerufen somit fällt der Vektor nicht auf [0,0] zurück!
	############################### Joystick ##############################	
	if event is InputEventJoypadButton:
		if event.pressed:
			# wenn eine Joybutton gedrückt gebe dessen Nummer aus
			$Label8.text = str(event.button_index)
		else:
			$Label8.text = ""
	if event is InputEventJoypadMotion:
		# wenn eine Achse vom Joystick verändert wurde
		if event.axis < 4:
			# wir werten 4 Achsen aus also z.B. beide Sticks vom GamePad
			stick[event.axis] = event.axis_value
		$Label9.text = str(stick)

func _process(delta):
	# diese Funktion wird bei jedem Frame aufgerufen
	if Input.is_key_pressed(KEY_E):
		# bei gedrückter Taste wird bei jedem Farme dieser Block abgearbeitet !!!
		$Label10.text = "Input Taste E"
	elif Input.is_key_pressed(KEY_R):
		$Label10.text = "Input Taste R"
	else:
		$Label10.text = ""
		#############################################
	# mit der folgenden Methode könnenn wir die Position des Mauszeigers ermitteln
	$Label11.text = str(get_viewport().get_mouse_position())
	################ Aufruf des SzeneReader ########
	################################################
	if Input.is_action_pressed("SzeneReader"):
		get_node("/root/AutoLoad").zu_SzeneReader()
	if Input.is_action_pressed("Hauptlevel"):
		get_node("/root/AutoLoad").zu_hauptszene()
	###############################################
	###############################################

func _exit_tree():
	# aktion wieder entfernen
	InputMap.action_erase_event("dummi_aktion", i_e_k)