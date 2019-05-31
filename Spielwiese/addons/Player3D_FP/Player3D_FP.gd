tool
extends EditorPlugin

# Export Variablen
func _enter_tree():
    # Initialization of the plugin goes here
    # Add the new type with a name, a parent type, a script and an icon
	add_custom_type("Player3D_FP", "Spatial", preload("Player3D_FP_init.gd") , preload("icon.png"))

func _exit_tree():
    # Clean-up of the plugin goes here
    remove_custom_type("Player3D_FP")
