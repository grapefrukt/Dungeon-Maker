package  {
	/**
	 * ...
	 * @author Martin Jonasson (m@webbfarbror.se)
	 */
	public class Settings{
	
		// defines the size of the dungeon excluding any surrounding walls
		// add 2px to each to get the total size (this happens in the rendererer)
		public static const 	GRID_W				:int 	= 66;
		public static const 	GRID_H				:int 	= 66;
		
		// number of splitting sweeps that are made see: generate()
		public static const 	SPLITTING_SWEEPS	:Number = 8;
		
		// rooms that would have a combined area larger than this will not be merged
		public static const 	MERGE_AREA_MAX:Number = 100;
		
		// chance of merging two adjacent rooms
		public static const 	MERGE_CHANCE:Number = 0.9;
		
		// defines the chance that a door is removed, 1 = no doors, 0 = all possible doors
		public static const 	DOOR_REMOVAL_CHANCE	:Number = 0.5;
		
		// the colors used in the renderer
		public static const COLOR_FLOOR		:uint = 0x8ebe55;
		public static const COLOR_UNREACHABLE	:uint = 0x000000;
		public static const COLOR_WALL			:uint = 0x2e2e2e;
		public static const COLOR_DOOR			:uint = 0xc459d1;
		public static const COLOR_ENTRANCE		:uint = 0x07f8fb;
		public static const COLOR_EXIT			:uint = 0xf91e71;
		
	}

}