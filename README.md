# ModCore

**A simple ModLoader library for Godot.**

ModCore is a lightweight, easy-to-use mod loading solution for your Godot games. It allows you to load external mods, enabling community-created content and easy game extensibility.


## Features

- **Simple Mod Loading** – Load mods from a designated folder with minimal setup.
- **Easy to Use** – Built with a straightforward API to integrate into any Godot project.
- **GDScript Native** – Written entirely in GDScript, making it easy to understand and modify.
- **Lightweight** – Designed to be a minimal and performant solution.


## Getting Started

### Installation

1. **Download** – Clone or download this repository.
2. **Add to Project** – In your Godot project, auto-load tge `ModCore.gd` it as a singleton.

### Basic Usage

1. **Create a Mods Folder** – In your game's user data directory (or a folder of your choice), create a folder named `mods`.

2. **Structure a Mod** – Each mod should be a subfolder inside the `mods` folder. The mod folder must contain a `mod.gd` script with a `Mod` class that extends `Node` (see the `example/TestMod` for a reference).

   ```
   user://mods/
   └── MyAwesomeMod/
       ├── mod.gd          # Main mod script
       └── (other files)   # Assets, scenes, etc.
   ```

3. **Load Mods** – In your game's startup logic, call the ModCore loader:

   ```gdscript
   # In your main script or singleton
   ModCore.load_mods("user://mods/")
   ```

   This will scan the folder and load all valid mods found.

4. **Interact with Mods** – Mods can extend your game's functionality by adding nodes, connecting signals, or overriding methods. Refer to the `example/TestMod/mod.gd` for a practical example.


## Example `mod.gd`

Here is a minimal example of a `mod.gd` file:

```gdscript
extends Node

class_name Mod

# Called when the mod is loaded
func _ready():
    print("Hello from MyAwesomeMod!")
    # Add your mod's logic here
```


## Requirements

- **Godot 4.x** (or compatible version – check the repository for specific version support)
- GDScript knowledge (basic scripting skills are sufficient)


## License

This project is licensed under the MIT license. See the LICENSE for more details.

Made with love by QKing
