extends RefCounted

var core
var label


func on_load(mod_core):
	core = mod_core

	core.on("game_start", Callable(self, "on_game_start"))
	core.hook("damage", Callable(self, "on_damage"))

	_create_ui()

	_log("Mod loaded: TestMod")

func _create_ui():
	var tree = Engine.get_main_loop() as SceneTree
	var root = tree.current_scene

	label = Label.new()
	label.text = "TestMod Active"
	label.position = Vector2(20, 20)

	root.add_child(label)


func _log(text:String):
	print(text)

	if label:
		label.text = label.text + "\n" + text

func on_game_start():
	_log("Game started")


func on_damage(value, player):
	var new_value = value + 5
	_log("Damage: %s -> %s" % [value, new_value])
	return new_value
