extends Node2D

var farbe = Color()
var bild = Image.new()

func _ready():
	# Mauszeiger sichtbar machen
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Zeiger auf das Image in dem Sprite 
	bild = $Sprite.get_texture().get_data()
	# Maximalwerte der Scrollbars auf Bildbreite
	$HScrollBar.max_value = bild.get_width() -1
	$HScrollBar2.max_value = bild.get_width() -1

func _on_HScrollBar_scrolling():
	bild.lock()
	# farbe an der Position (x,3) des Bildes ermitteln
	farbe = bild.get_pixel($HScrollBar.value,3)
	bild.unlock()
	# Hiermit wird die Hintergrundfrabe festgelegt
	VisualServer.set_default_clear_color(farbe) 


func _on_HScrollBar2_scrolling():
	bild.lock()
	# farbe an der Position (x,3) des Bildes ermitteln
	farbe = bild.get_pixel($HScrollBar2.value,3)
	bild.unlock()
	# Dieses Node färbt alle Objekte der Szene ein
	$CanvasModulate.color = farbe

func _exit_tree():
	# Ursprüngliche Hintergrundfarbe wieder herstellen
	VisualServer.set_default_clear_color(Color(0.3,0.3,0.3,1.0))