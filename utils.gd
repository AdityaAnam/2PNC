extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var current_scene = null


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)



func get_ip():
	var ip = ""
	for address in IP.get_local_addresses():
		if (address.split('.')[0] == "192"):
			ip=address
	return ip


func get_scene_path(scene):
	return "res://%s.tscn"%scene


func deferred_goto_scene(scene,hide=false):
	current_scene.hide()
	if hide:
		current_scene.hide()
	else:
		current_scene.free()
	var s = ResourceLoader.load(get_scene_path(scene))
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)


remote func goto_scene(scene):
	call_deferred("deferred_goto_scene", scene)

remote func add_scene(scene):
	call_deferred("deferred_goto_scene", scene,true)

func hide():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


