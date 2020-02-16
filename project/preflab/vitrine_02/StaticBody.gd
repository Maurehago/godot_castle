extends StaticBody

func player_interact(Player):
	if Input.is_action_pressed("ui_nr_1"):
		get_node("/root/AutoLoad").zu_nebenszene(get_parent().Szene_1)
	if Input.is_action_pressed("ui_nr_2"):
		get_node("/root/AutoLoad").zu_nebenszene(get_parent().Szene_2)
	if Input.is_action_pressed("ui_nr_3"):
		get_node("/root/AutoLoad").zu_nebenszene(get_parent().Szene_3)
