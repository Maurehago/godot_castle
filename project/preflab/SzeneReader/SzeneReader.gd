extends Node2D

var Baum = []
var szene_namen
var zeit :int

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# diese Funktion liest die Szenedatei ein, zerlegt die daten und schreibt diese in das Array Baum
	var zkette_feld = []	# liste aller Strings
	var meta_feld = []		# liste aller Meta_daten
	var dic_feld = {}
	var obj_feld = []		# objektzeilen
	var para_paare = []		# alle Parameterpaare einer objektzeile
	var paar = []			# Parameterpaar
	var dummi_feld = []
	var file = File.new()
	szene_namen = get_node("/root/AutoLoad").NebenSzene
	$SzenenName.text = szene_namen
	file.open(szene_namen, file.READ)
	var skript = file.get_as_text()
	file.close()
	var tex_start : int
	var tex_ende : int
	var tex_lang : int
	var tex2_start : int
	var textstelle : String
	var id : int
	var id_meta : int
	var obj_typ :String
	zeit = OS.get_system_time_secs()
	# innerhalb von Strings werden " in \" umgewandelt. dies Zeichenpaar ersetzen
	skript = skript.replace(char(92)+'"', "°+stzafz+°")
	# kopiere alle Metadaten raus und ersetze die Stellen durch °#id#°
	tex_start = skript.find('__meta__')
	while tex_start > -1:
		tex_ende = skript.find('}', tex_start + 1)
		if tex_ende > -1:
			tex2_start  = skript.find('{', tex_start + 1) + 1
			tex_lang = tex_ende - tex2_start
			# die Parameterpaare in textstelle kopieren und säubern
			textstelle = skript.substr(tex2_start, tex_lang)
			textstelle = textstelle.strip_edges()
			textstelle = textstelle.replace("\n", " ")
			textstelle = textstelle.replace('"', '')
			# die paare aufsplitten und in Dictionary schreiben
			var paare = textstelle.split(", ")
			for paar in paare:
				var pa = paar.split(":")
				dic_feld[pa[0]] = pa[1].strip_edges() 
			id = meta_feld.size()
			# Dictionary in Feld übertragen
			meta_feld.append(dic_feld)
			dic_feld = {}
			tex_lang = tex_ende - tex_start + 1
			# Meta_text aus Skript löschen
			skript.erase(tex_start, tex_lang)
			# Zeiger im Skript auf Metadaten setzen
			skript = skript.insert(tex_start, "°#"+str(id)+"#°")
			tex_start = skript.find('__meta__', 0)
		else:
			# Schreife abbrechen es gibt kein endtag
			tex_start = -1
	# kopiere alle Texte welche in anführungszeichen stehen raus und ersetze die Stellen durch °*id*°
	tex_start = skript.find('"')
	while tex_start > -1:
		tex_ende = skript.find('"', tex_start + 1)
		if tex_ende > -1:
			tex_start += 1
			tex_lang = tex_ende - tex_start
			textstelle = skript.substr(tex_start, tex_lang)
			id = zkette_feld.size()
			zkette_feld.append(textstelle)
			tex_start -= 1
			skript.erase(tex_start, tex_lang + 2)
			skript = skript.insert(tex_start, "°*"+str(id)+"*°")
			tex_start = skript.find('"')
		else:
			# Schreife abbrechen es gibt kein endtag
			tex_start = -1
	skript = skript.replace("( ", "(")
	skript = skript.replace(" )", ")")
	skript = skript.replace(", ", ",")
	skript = skript.replace("\n", " ")
	skript = skript.replace("]", "")
	skript = skript.replace(" = ", "=")
	obj_feld = skript.split("[")
	dic_feld = []
	id_meta = -1
	for x in obj_feld:
		x = x.strip_edges()
		para_paare = x.split(" ")
		for y in para_paare:
			paar = y.split("=")
			# wenn es ein parameterpaar ist
			if paar.size() == 2:
				textstelle = paar[0]
				tex_start = paar[1].find("°*")
				if tex_start > -1:
					# wenn Parameterwert ein String
					tex_ende =  paar[1].find("*°")
					tex_lang = tex_ende - tex_start
					id = int(paar[1].substr(tex_start, tex_lang))
					dic_feld[textstelle] = '"'+zkette_feld[id]+'"'
				else:
					# wenn Parameterwert eine Zahl
					dic_feld[textstelle] = paar[1]
			# wenn es kein paar ist kann es nur der Typ sein oder meta_daten
			elif paar.size() == 1:
				tex_start = paar[0].find("°#")
				# wenn es meta_daten sind
				if tex_start > -1:
					tex_ende =  paar[0].find("#°")
					tex_lang = tex_ende - tex_start
					id_meta = int(paar[0].substr(tex_start, tex_lang))
				# wenn des der Objekttyp ist
				else:
					obj_typ = paar[0]
		if id_meta > -1:
			dummi_feld = [obj_typ, dic_feld, meta_feld[id_meta]]
		else:
			dummi_feld = [obj_typ, dic_feld]
		obj_typ = ""
		dic_feld = {}
		id_meta = -1
		Baum.append(dummi_feld)
	daten_zum_baum()

func daten_zum_baum():
	# diese Funktion liest das Baum-Array aus und überträgt die entsprechenden Daten in die Tree-Ansicht
	var vater : String
	var sohn : String
	var baum_zeiger = {}
	var resourcen = []
	var kleinste_id : int = 9999999
	var root_skript : String
	for x in Baum:
		if x[0] == "node":
			var paara = x[1]
			var namen = paara.name.substr(1, paara.name.length()-2)
			if paara.has("parent"):
				# der Parameter parent enthält die Pfadangabe in der Baumansicht, wobei der Root-node als einziges keine parent angabe besitzt.
				# eine besonderheit ist, dass alle Nodes direkt unter dem Root als Pfadangabe einen . enthalten.
				var weg = paara.parent.substr(1, paara.parent.length()-2)
				if weg == ".":
					vater = "root"
					sohn = vater + "/" + namen
				else:
					vater = "root/" + weg
					sohn = vater + "/" + namen
				baum_zeiger[sohn] = $Tree.create_item(baum_zeiger[vater])
				baum_zeiger[sohn].set_text(0,namen)
			else:
				baum_zeiger.root = $Tree.create_item()
				baum_zeiger.root.set_text(0,namen)
		# und die resourcen
		elif x[0] == "ext_resource":
			resourcen.append(x[1])
	# suche das Skript mit der niedrigsten ID
	for x in resourcen:
		if x.type == '"'+"Script"+'"':
			if kleinste_id > x.id.to_int():
				kleinste_id = x.id.to_int()
				root_skript = x.path.substr(1, x.path.length() - 2)
	# und lade es in den TextEdit
	var file = File.new()
	file.open(root_skript, file.READ)
	$TextEdit.text = file.get_as_text()
	file.close()

func daten_aus_feld(objekttyp,weg):
	# diese Funktion sucht im Baum-Array nach objekttyp und weg und speichert diesen zweig in datensatz
	objekttyp = '"'+objekttyp+'"'
	weg = '"'+weg+'"'
	var datensatz =[]
	var start_z : int
	var end_z : int
	for x in Baum:
		if x[0] == "node":
			var dummi = x[1]
			if dummi.has("parent"):
				if dummi.parent == weg and dummi.name == objekttyp:
					datensatz = x
					break
			else:
				# nur der root-Node hat kein parent
				if weg.length() == 2 and dummi.name == objekttyp:
					datensatz = x
					break
	# als nächstes alle Schlüssel und dessen Werte in die ItemList
	var schluessel_liste = datensatz[1].keys()
	$ItemList.clear()
	for x in schluessel_liste:
		$ItemList.add_item(x)
		var text = datensatz[1][x]
		# wenn der Wert ein ExtResource ist, tausche gegen path
		if text.findn("ExtResource") > -1:
			start_z = text.find('(',0)
			end_z = text.find(')',start_z)
			var id = text.substr(start_z + 1, end_z - start_z - 1)
			for y in Baum:
				if y[0] == "ext_resource":
					if y[1].id == id:
						text = y[1].path
						# wenn die ExtResource als Schlüssel ein skript ist, lade die Datei
						if x.findn("script") > -1:
							text = text.substr(1,text.length() -2)
							var file = File.new()
							file.open(text, file.READ)
							$TextEdit.text = file.get_as_text()
							file.close()
						break
		# wenn der Wert ein sub_resource ist, tausche gegen type
		elif text.findn("SubResource") > -1:
			start_z = text.find('(',0)
			end_z = text.find(')',start_z)
			var id = text.substr(start_z + 1, end_z - start_z - 1)
			for y in Baum:
				if y[0] == "[sub_resource":
					if y[1].id == id:
						text = y[1].type
						break
		$ItemList.add_item(text)
	# wenn Metadaten vorhanden
	if datensatz.size() == 3:
		var meta = datensatz[2].keys()
		$Metadaten.text = str(meta)
	else:
		$Metadaten.text = ""

func _on_Tree_cell_selected():
	# diese Funktion wird aufgerufen wenn auf eine Zeile in der Baumansicht geklickt wird.
	# zunächst bauen wir die Pfadangabe wieder zusammen um über diese und dem objekttyp im Baum-Array die entsprechende Zeile zu finden.
	var zweig = $Tree.get_selected()
	var weg = []
	var vater = zweig.get_parent()
	var objekttyp = zweig.get_text(0)
	while vater:
		weg.append(vater.get_text(0))
		vater = vater.get_parent()
	if weg.size() == 0:
		# root und hat kein parent
		daten_aus_feld(objekttyp,"")
		return
	elif weg.size() == 1:
		# parent = "."
		daten_aus_feld(objekttyp,".")
		return
	else:
		# parent = weg
		var dummi : String = ""
		for a in range(weg.size()-2,-1, -1):
			dummi += weg[a] + "/"
		var dummi_a = dummi.substr(0,dummi.length()-1)
		daten_aus_feld(objekttyp,dummi_a)

func _on_ItemList_item_selected(index):
	# wenn auf das SchlüsselItem geklickt wurde dann +1
	if index%2 == 0:
		index += 1
	# zeige get_Item_Text in Label.text an
	$ItemText.text = $ItemList.get_item_text(index)

func _process(delta):
	# damit ständiges umherspringen vermieden wird, muss die Szene mindest 1 sec aktiv sein
	if Input.is_action_pressed("SzeneReader"):
		get_node("/root/AutoLoad").back_nebenszene()
	if Input.is_action_pressed("Hauptlevel"):
		get_node("/root/AutoLoad").zu_hauptszene()
#	if Input.is_action_pressed("SzeneReader") and OS.get_system_time_secs() - zeit > 1:
#		get_tree().change_scene(szene_namen)
