extends Sprite

var bild = get_texture().get_data()
var farbe = Color()
#var bilddaten

func _ready():
	$HScrollBar.max_value = bild.get_width()-2
	$HScrollBar2.max_value = bild.get_width()-2
	print(bild.get_height())
	print(bild.get_width())
	

func _on_HScrollBar_scrolling():
	bild.lock()
	farbe = bild.get_pixel($HScrollBar.value, 3)
	VisualServer.set_default_clear_color(farbe)
	bild.unlock()


func _on_HScrollBar2_scrolling():
	bild.lock()
	farbe = bild.get_pixel($HScrollBar2.value, 3)
	$CanvasModulate.color = farbe
	bild.unlock()