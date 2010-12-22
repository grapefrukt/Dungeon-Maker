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
	
	public class Room extends Rect {
		
		private var _index				:int = 0;
		private var _split_count		:int = 0;
		
		private var _merged_room_area	:int = 0;
		private var _parent				:Room;
		
		private var _adjacent_rooms		:Vector.<Room>;
		private var _merged_rooms		:Vector.<Room>;
		private var _doors_to_rooms		:Vector.<Room>;
		
		public static const HORIZONTAL	:int = 0;
		public static const VERTICAL	:int = 1;
		
		public static const EAST		:int = 0;
		public static const WEST		:int = 1;
		public static const NORTH		:int = 2;
		public static const SOUTH		:int = 3;
		
		public function Room(x:int, y:int, width:int, height:int, iteration:int = 0, index:int = 0) {
			super(x, y, width, height);
			_index 				= index;
			_split_count 		= iteration;
			_adjacent_rooms 	= new Vector.<Room>;
		}
		
		public function findEdges(edges:Vector.<Edge>):void {
			for each(var room:Room in _adjacent_rooms) {
				edges.push(findCommonEdge(room))
			}
		}
		
		public function randomMerge():void {
			if (parent) return;
			
			for each(var room:Room in _adjacent_rooms) {
				if (!room.parent && room.totalArea < Settings.MERGE_AREA_MAX && Math.random() < Settings.MERGE_CHANCE) {
					this.mergeAsParent(room);
				}
			}
		}
		
		public function mergeAsParent(target:Room):void {
			if (!_merged_rooms) _merged_rooms = new Vector.<Room>;
			_merged_rooms.push(target);
			_merged_room_area += target.area;
			removeFromAdjacent(target);
			
			for each(var child:Room in target.mergedRooms) {
				mergeAsParent(child);
			}
			
			target.mergeAsChild(this);
		}
		
		public function mergeAsChild(parent:Room):void {
			removeFromAdjacent(parent);
			for each(var room:Room in parent.mergedRooms) {
				removeFromAdjacent(room);
				room.removeFromAdjacent(this);
			}
			
			_merged_rooms = null;
			_merged_room_area = 0;
			_parent = parent; 
		}
		
		public function removeFromAdjacent(room:Room):void {
			var index:int = _adjacent_rooms.indexOf(room);
			if (index >= 0) _adjacent_rooms.splice(index, 1);
		}
		
		/**
		 * Finds adjacent rooms
		 * @param	rooms a list of rooms to check against
		 */
		public function findAdjacent(rooms:Vector.<Room>):void {
			// we loop over the list of rooms
			for each (var room:Room in rooms) {
				// if the room we're checking is this room, we skip it. 
				if (room == this) continue;
				
				// we only want rooms that have actual common sides
				// diagonally adjacent rooms are no good, so first we make sure
				// the room isn't *only* touching any of the corners
				// the east/west/north/south properties are shortcuts to the side coords of the rooms
				
				if (room.west == this.east && room.north == this.south) continue;
				if (room.west == this.east && room.south == this.north) continue;
				
				if (room.south == this.north && room.east == this.west) continue;
				if (room.south == this.north && room.west == this.east) continue;
				
				// test for adjacency
				if (hasCommonSideE(room) || hasCommonSideW(room) || hasCommonSideN(room) || hasCommonSideS(room)) {
					
					// if the rooms is adjacent, we add it to the rooms list of neigbours
					_adjacent_rooms.push(room);
				}
			}
		}
		
		/**
		 * Splits the room in half
		 * @param	index	a unique index to identify the room
		 * @return	the new half of the room
		 */
		public function split(index:int):Room {
			// the room keeps track of how many times it's been split
			_split_count++;
			
			// this is used as an intermediary variable to hold the rooms size
			var oldSize:int = 0;
			
			// depending on if this is an even or odd split we slice the room either
			// horizontally or vertically
			if (_split_count % 2) {
				
				// this is where we need the intermediary var to store the current height of the room
				oldSize = height;
				// then, make the room half the height
				height = height / 2;
				
				// the height is an integer, so every now and then we'll loose half a pixel to rounding, 
				// that's why the oldSize var is needed
				
				// now we create a room that fills the space this room used to take up 
				// before we made it half size
				// the new room will also inherit this rooms split count
				return new Room(x, y + height, width, oldSize - height, _split_count, index);
			} else {
				// same procedure as above, but we split the room width instead
				oldSize = width;
				width = width / 2;
				return new Room(x + width, y, oldSize - width, height, _split_count, index);
			}
			
			return null;
		}
		
		public function addDoorToRoom(room:Room):void {
			if (!_doors_to_rooms) _doors_to_rooms = new Vector.<Room>;
			_doors_to_rooms.push(room);
		}
		
		public function removeDoorToRoom(room:Room):void {
			_doors_to_rooms.splice(_doors_to_rooms.indexOf(room), 1);
		}
		
		private function findCommonEdge(room:Room):Edge {
			var edge:Edge = new Edge(room, this);
			
			var commonSide:int = findCommonSide(room);
			
			if (commonSide == EAST || commonSide == WEST) {
				edge.y = Math.max(room.y, this.y);
				edge.length = Math.min(room.north, this.north) - edge.y;
				edge.direction = Room.VERTICAL;
			}
			
			if (commonSide == SOUTH || commonSide == NORTH) {
				edge.x = Math.max(room.x, this.x);
				edge.length = Math.min(room.east, this.east) - edge.x;
				edge.direction = Room.HORIZONTAL;
			}
			
			if (commonSide == EAST) edge.x = this.east;
			if (commonSide == WEST) edge.x = this.x;
			
			if (commonSide == SOUTH) edge.y = this.north;
			if (commonSide == NORTH) edge.y = this.y;
			
			return edge;
		}
		
		private function findCommonSide(room:Room):int {
			if (hasCommonSideE(room)) return EAST;
			if (hasCommonSideW(room)) return WEST;
			if (hasCommonSideN(room)) return NORTH;
			if (hasCommonSideS(room)) return SOUTH;
			return -1;
		}
		
		private function hasCommonSideW(room:Room):Boolean {
			return room.east == this.west && room.south >= this.south && room.south <= this.north;
		}
		
		private function hasCommonSideE(room:Room):Boolean {
			return room.west == this.east && room.south >= this.south && room.south <= this.north;
		}
		
		private function hasCommonSideN(room:Room):Boolean {
			return room.north == this.south && room.west >= this.west && room.west <= this.east;
		}
		
		private function hasCommonSideS(room:Room):Boolean {
			return room.south == this.north && room.west >= this.west && room.west <= this.east;
		}
		
		public function get adjacentRooms():Vector.<Room> { return _adjacent_rooms; }
		public function get parent():Room { return _parent; }
		public function get hasMergedRooms():Boolean { return _merged_rooms != null; }
		public function get totalArea():int { return area + _merged_room_area; }
		public function get mergedRooms():Vector.<Room> { return _merged_rooms; }
		public function get index():int { return _index; }
		
		public function get doorsToRooms():Vector.<Room> { return _doors_to_rooms; }
		
	}

}