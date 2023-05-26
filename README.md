# Phase Pioneer

Next Up:
	
		Look into using custom resources for effects and to replace autoload for weapons
		So weapons and effects are custom classes that load these resources which can be edited outside
		of Godot engine. Resources can also be used for the in game library/codex info.
		
		Remove unecessary class_name and other type specification done to make autocomplete visible,
		since that's just janky anyway. Instead rely on class type asserts to guarantee that function calls and
		variable accesses missing in autocomplete are valid. Those asserts can use class_names. Otherwise,
		use them exclusively for interfaces.
	
		Effect management
		
			Autoload? Inner classes of an effect manager class?
			
			First effect: Light of the Nexus - prevents light energy drain, for use in arena
	
		Start making base classes
	
			Tilesets need standardization - Arena uses HexTileMapBase now, make sure overworld map does too and
			give the base some common script elements

Planned:
	
	Add Library/Codex thing
	
		Do that fancy thing where library entries have link text like a wiki
	
	Cleanup player, tile_map scripts for consistency
	
	Add encroaching shadows on map that either replace or complement light meter
	
	Make game end when map radius reaches 0
	
	Iframes for damage
	
	Elemental damage system
	
	Spawn location with no enemies
	
	Cleaner mapgen with nicer looking stuff
	
	Additional layer on tileset with decor
	
	High aberrance generates holes in map and other "weird" structures
	
	Minimap and pointers to points of interest
	
	Review mapgen to make sure no all floats are rounded to ints and not floored
	
	Cooler looking HP, Mana, Light bars - think Path of Exile
	
	Figure out what player group is being used for - forgot
	
	Make neighbor tile calculations use "memory" neighbors for weaker values instead

Future Reference:
	
	Make different enemies behave differently in response to de-manifested hexes - some disappear with the hexes, some
	keep approaching through the nothingness, etc.
