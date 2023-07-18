# Phase Pioneer

Next Up:
	
	Continue implementing equipment as resources
	
		Look into using custom resources for effects and to replace autoload for weapons
		So weapons and effects are custom classes that load these resources which can be edited outside
		of Godot engine. Resources can also be used for the in game library/codex info.
		
			Partially done for effects. Next is weapons. Note: bug with charged attack, seems to leave
			behind a sprite?
		
		Remove unnecessary class_name and other type specification done to make autocomplete visible,
		since that's just janky anyway. Instead rely on class type asserts to guarantee that function calls and
		variable accesses missing in autocomplete are valid. Those asserts can use class_names. Otherwise,
		use them exclusively for interfaces.
		
			Might be done, need to review.
	
		Effect management
		
			Autoload? Inner classes of an effect manager class?
			
			First effect: Light of the Nexus - prevents light energy drain, for use in arena
			
			Implemented as a "handler" that can be applied as a node to any object. Should probably
			use this paradigm for all similar use cases.
	
		Start making base classes
	
			Tilesets need standardization - Arena uses HexTileMapBase now, make sure overworld map does too and
			give the base some common script elements

Planned:
	
	Instead of Light meter, use a "reality sync" meter. Has positive and negative sides. Starts game with only positive side, 0 - 100. Closer to 0 means more and more debuffs
	Still goes down over time. If it hits a minimum (-100?) you end your run.
	
		"Oneiromancy" stats/tree allows you to benefit from instability
		
			Capstone: Shifts your meter from 0 - 100 to -50 - 50, so always starts unstable and can overtune instability effects
		
		"Alethiomancy" stats/tree slows down or lets you control stability loss
	
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

 	Universal blur (and other effects) on text when it changes mid-sentence, or when boss titles change, etc

  	Skill tree unlock: after collecting 5 artifacts? Unlocks dungeons; once you're close to losing to the OP dungeon gatekeeper
   	Vittoria shows up Mysterious Stranger style and oneshots it, unlocks your skill tree, tells you not to try dungeon or you'll 	die

		Town unlock: after completing one dungeon? Unlocks memorable vistas; before you can fight the guardian, Wynstan memes it to 	atoms and gives you the vista for free

  	Story "training" bosses:

   		Calypso of Light and Dark: Switches between attack types, shadows position and phantasms attack - Grants Pendulum 		casting style

	 		Calypso the Dreamer: Fantasy themed, glassblowing pipe used like a bubble wand, bubbles shatter and release 			butterflies - Grants Oneiromancy

Future Reference:
	
	Make different enemies behave differently in response to de-manifested hexes - some disappear with the hexes, some
	keep approaching through the nothingness, etc.
