extends Node

const RES_MODS := "res://mods"
const USER_MODS := "user://mods"

var _events := {}
var _hooks := {}
var _overrides := {}
var _mods := []


func _ready():
	load_mods()

func load_mods():
	print("ModCore: Loading mods...")

	_load_from_folder(RES_MODS, false)
	_load_from_folder(USER_MODS, true)

	print("ModCore: Loaded ", _mods.size(), " mods total.")


func _load_from_folder(path:String, writable:bool):
	var dir = DirAccess.open(path)

	if dir == null:
		print("ModCore: Creating missing folder -> ", path)
		DirAccess.make_dir_recursive_absolute(path)
		return

	dir.list_dir_begin()

	while true:
		var folder = dir.get_next()

		if folder == "":
			break

		if !dir.current_is_dir():
			continue

		var mod_path = path + "/" + folder + "/mod.gd"

		if !ResourceLoader.exists(mod_path):
			continue

		var script = load(mod_path)
		var mod = script.new()

		mod.set_meta("mod_name", folder)
		mod.set_meta("source", path)

		_mods.append(mod)

		if mod.has_method("on_load"):
			mod.on_load(self)

		print("Loaded mod:", folder, "from", path)

	dir.list_dir_end()

func on(event:String, callable:Callable):
	if !_events.has(event):
		_events[event] = []
	_events[event].append(callable)


func emit(event:String, args:Array=[]):
	if !_events.has(event):
		return

	for c in _events[event]:
		if c.is_valid():
			c.callv(args)

func hook(name:String, callable:Callable):
	if !_hooks.has(name):
		_hooks[name] = []
	_hooks[name].append(callable)


func modify(name:String, value, args:Array=[]):
	if !_hooks.has(name):
		return value

	var current = value

	for c in _hooks[name]:
		if c.is_valid():
			var call_args = [current]
			call_args.append_array(args)
			current = c.callv(call_args)

	return current

func register_override(name:String, callable:Callable):
	_overrides[name] = callable


func has_override(name:String) -> bool:
	return _overrides.has(name)


func call_override(name:String, args:Array=[]):
	if !_overrides.has(name):
		return null
	return _overrides[name].callv(args)

func list_mods():
	for m in _mods:
		print("Mod:", m.get_meta("mod_name"), "from", m.get_meta("source"))
