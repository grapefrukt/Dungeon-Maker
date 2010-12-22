package {
	
	/**
	 * Licensed under the MIT License
	 * 
	 * Copyright (c) 2010 Martin Jonasson
	 * 
	 * Permission is hereby granted, free of charge, to any person obtaining a copy
	 * of this software and associated documentation files (the "Software"), to deal
	 * in the Software without restriction, including without limitation the rights
	 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	 * copies of the Software, and to permit persons to whom the Software is
	 * furnished to do so, subject to the following conditions:
	 * 
	 * The above copyright notice and this permission notice shall be included in
	 * all copies or substantial portions of the Software.
	 * 
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	 * THE SOFTWARE.
	 * 
	 * http://www.prototyprally.com/dungeonmaker/
	 * 
	 * @author Martin Jonasson (m@grapefrukt.com)
	 */
	
	public class Settings {
	
		// defines the size of the dungeon excluding any surrounding walls
		// add 2px to each to get the total size (this happens in the rendererer)
		public static const 	GRID_W				:int 	= 66;
		public static const 	GRID_H				:int 	= 66;
		
		// number of splitting sweeps that are made see: generate()
		public static const 	SPLITTING_SWEEPS	:Number = 8;
		
		// rooms that would have a combined area larger than this will not be merged
		public static const 	MERGE_AREA_MAX		:Number = 100;
		
		// chance of merging two adjacent rooms
		public static const 	MERGE_CHANCE		:Number = 0.9;
		
		// defines the chance that a door is removed, 1 = no doors, 0 = all possible doors
		public static const 	DOOR_REMOVAL_CHANCE	:Number = 0.5;
		
		// the colors used in the renderer
		public static const COLOR_FLOOR			:uint = 0x8ebe55;
		public static const COLOR_UNREACHABLE	:uint = 0x000000;
		public static const COLOR_WALL			:uint = 0x2e2e2e;
		public static const COLOR_DOOR			:uint = 0xc459d1;
		public static const COLOR_ENTRANCE		:uint = 0x07f8fb;
		public static const COLOR_EXIT			:uint = 0xf91e71;
		
	}

}